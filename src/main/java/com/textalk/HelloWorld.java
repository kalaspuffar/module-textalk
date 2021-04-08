package com.textalk;

import com.xmlcalabash.core.XProcException;
import com.xmlcalabash.core.XProcRuntime;
import com.xmlcalabash.core.XProcStep;
import com.xmlcalabash.io.ReadablePipe;
import com.xmlcalabash.io.WritablePipe;
import com.xmlcalabash.library.DefaultStep;
import com.xmlcalabash.model.RuntimeValue;
import com.xmlcalabash.runtime.XAtomicStep;
import net.sf.saxon.s9api.QName;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.Serializer;
import org.daisy.common.xproc.calabash.XProcStepProvider;
import org.osgi.framework.FrameworkUtil;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import javax.xml.transform.stream.StreamSource;

public class HelloWorld extends DefaultStep implements XProcStep {

    private static final QName _html = new QName("html");
    private static final QName _greeting = new QName("greeting");

    private ReadablePipe source = null;
    private WritablePipe result = null;
    private final Map<String,String> params = new HashMap<String,String>();

    public HelloWorld(XProcRuntime runtime, XAtomicStep step) {
        super(runtime, step);
    }

    @Override
    public void setInput(String port, ReadablePipe pipe) {
        source = pipe;
    }

    @Override
    public void setOutput(String port, WritablePipe pipe) {
        result = pipe;
    }

    @Override
    public void setParameter(String port, QName name, RuntimeValue value) {
        if ("parameters".equals(port))
            setParameter(name, value);
        else
            throw new XProcException("No parameters allowed on port '" + port + "'");
    }

    @Override
    public void setParameter(QName name, RuntimeValue value) {
        if ("".equals(name.getNamespaceURI()))
            params.put(name.getLocalName(), value.getString());
    }

    @Override
    public void reset() {
        source.resetReader();
        result.resetWriter();
    }

    @Override
    public void run() throws SaxonApiException {
        super.run();
        try {

            // Read FILE
            ByteArrayOutputStream s = new ByteArrayOutputStream();
            Serializer serializer = runtime.getProcessor().newSerializer();
            serializer.setOutputStream(s);
            serializer.setCloseOnCompletion(true);
            serializer.serializeNode(source.read());
            serializer.close();
            InputStream fileStream = new ByteArrayInputStream(s.toByteArray());
            s.close();

            // Convert
            // FIXME: duplication with DotifyTaskSystem! => use that class in
            // here (like in XMLToOBFL) when it supports setting of the mode
            String html = getOption(_html).getString();
            String greeting = getOption(_greeting).getString();

            logger.info(html);

            String resultString = "Hello " + greeting;

            InputStream pefStream = new ByteArrayInputStream(resultString.getBytes(StandardCharsets.UTF_8));

            // Write Result
            result.write(runtime.getProcessor().newDocumentBuilder().build(new StreamSource(pefStream)));
            pefStream.close(); }

        catch (Throwable e) {
            logger.error("textalk:hello-world failed", e);
            throw new XProcException(step.getNode(), e); }
    }


    @Component(
            name = "textalk:hello-world",
            service = { XProcStepProvider.class },
            property = { "type:String={http://textalk.com/p/textalk/}hello-world" }
    )
    public static class Provider implements XProcStepProvider {
        @Override
        public XProcStep newStep(XProcRuntime runtime, XAtomicStep step) {
            return new HelloWorld(runtime, step);
        }
    }

    private static final Logger logger = LoggerFactory.getLogger(HelloWorld.class);

    private static abstract class OSGiHelper {
        static boolean inOSGiContext() {
            try {
                return FrameworkUtil.getBundle(OSGiHelper.class) != null;
            } catch (NoClassDefFoundError e) {
                return false;
            }
        }
    }
}