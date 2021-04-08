<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:textalk="http://textalk.com/p/textalk/"
           version="1.0">

    <p:declare-step type="textalk:hello-world">
        <p:input port="source" sequence="false"/>
        <p:output port="validation-status" sequence="false"/>
        <p:output port="report" sequence="false"/>
        <p:option name="html" required="true"/>
        <p:option name="greeting" required="false"/>
        <!--
            Implemented in ../../java/org/daisy/pipeline/braille/dotify/calabash/impl/OBFLToPEFStep.java
        -->
    </p:declare-step>
</p:library>