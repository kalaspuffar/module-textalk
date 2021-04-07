<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
                type="px:module-textalk-hello-world" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:l="http://xproc.org/library" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
                xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:opf="http://www.idpf.org/2007/opf">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Textalk hello world</h1>
        <p px:role="desc">This script will take some simple input and return a report.</p>
    </p:documentation>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
    </p:output>

    <p:option name="html-report" required="true" px:output="result" px:type="anyDirURI" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
    </p:option>

    <p:option name="book" required="true" px:type="anyFileURI" px:media-type="application/xhtml+xml">
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

</p:declare-step>
