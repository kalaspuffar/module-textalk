import org.daisy.pipeline.junit.AbstractXSpecAndXProcSpecTest;

import org.ops4j.pax.exam.Configuration;
import static org.ops4j.pax.exam.CoreOptions.composite;
import static org.ops4j.pax.exam.CoreOptions.options;
import org.ops4j.pax.exam.Option;

public class XProcSpecTest extends AbstractXSpecAndXProcSpecTest {

    @Override
    protected String[] testDependencies() {
        return new String[] {
            pipelineModule("common-utils"),
            pipelineModule("file-utils"),
            pipelineModule("fileset-utils"),
            pipelineModule("html-utils"),
            pipelineModule("mediatype-utils"),
            pipelineModule("validation-utils"),
        };
    }

    @Override @Configuration
    public Option[] config() {
        return options(composite(super.config()));
    }
}
