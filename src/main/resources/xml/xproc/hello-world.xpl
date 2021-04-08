<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
                type="px:module-textalk-hello-world" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:textalk="http://textalk.com/p/textalk/">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Textalk hello world</h1>
        <p px:role="desc">This script will take some simple input and return a report.</p>
    </p:documentation>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
<!--
        <p:docmentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:docmentation>
-->
        <p:pipe port="status.out" step="hello-world.do-greeting"/>
    </p:output>

    <p:option name="html-report" required="true" px:output="result" px:type="anyDirURI" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
    </p:option>

    <p:option name="html" required="true" px:type="anyFileURI" px:media-type="application/xhtml+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Book to test</h2>
            <p px:role="desc">Book to test with framework</p>
        </p:documentation>
    </p:option>

    <p:option name="greeting" required="false" px:type="string" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">String to greet with</h2>
            <p px:role="desc">String to greet with</p>
        </p:documentation>
    </p:option>

    <p:import href="library.xpl"/>
    <!--
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <px:normalize-uri name="html">
        <p:with-option name="href" select="resolve-uri($html,static-base-uri())"/>
    </px:normalize-uri>
    <px:normalize-uri name="html-report">
        <p:with-option name="href" select="resolve-uri($html-report,static-base-uri())"/>
    </px:normalize-uri>
    <px:message message="Link: $1">
        <p:with-option name="param1" select="$html"/>
    </px:message>
    <p:sink/>
    -->

    <textalk:hello-world name="hello-world.do-greeting">
        <p:input port="source">
            <p:inline>
                <doc>Hello world!</doc>
            </p:inline>
        </p:input>
        <p:with-option name="html" select="$html"/>
        <p:with-option name="greeting" select="$greeting"/>
    </textalk:hello-world>

    <p:choose name="hello-world.report">
        <p:xpath-context>
            <p:pipe port="status.out" step="hello-world.do-greeting"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok'">
            <p:output port="report.out" sequence="true" primary="true">
                <p:pipe port="report" step="hello-world.do-greeting"/>
            </p:output>

            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:when>
        <p:otherwise>
            <p:output port="report.out" sequence="true" primary="true">
                <p:pipe port="report" step="hello-world.do-greeting"/>
            </p:output>

            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:otherwise>
    </p:choose>
</p:declare-step>
