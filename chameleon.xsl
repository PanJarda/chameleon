<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system=""/>
    <xsl:template match="/chameleon">

        <html class="hovnobook-html">
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <title>
                    Hovnobook
                </title>
                <style>
                    html {
                        font-size: 62.5%;
                    }

                    body {
                        font-size: 1.6rem;
                        font-family: sans-serif;
                    }

                    body,
                    html {
                        margin: 0;
                        padding: 0;
                    }
                    .hovnobook_tab {
                        display: none;
                    }

                    .hovnobook_tab_label {
                        position: relative;
                        padding: 10px;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                        display: block;
                        color: #fff;
                        cursor: pointer;
                        user-select: none;
                    }

                    .hovnobook_tab_label:hover {
                        background: rgba(0, 0, 0, 0.2);
                        color: #2652CC;
                    }

                    .hovnobook_tabs_container{
                        position: relative;
                        background: #2652CC;
                        width: 100%;
                    }

                    .hovnobook_tab_label:hover {
                        background-color: #eee;
                    }

                    .hovnobook_main {
                        position: relative;
                        padding: 15px;
                        box-sizing: border-box;
                        display: block;
                    }

                    .hovnobook_content {
                        display: none;
                    }

                    .hovnobook_tab:checked + .hovnobook_content {
                        display: block;
                        animation: slide 0.5s forwards;
                    }

                    @media screen and (min-width: 400px) {
                        body {
                            padding-left: 200px;
                        }

                        .hovnobook_tabs_container {
                            width: 200px;
                            position: fixed;
                            left: 0;
                            bottom: 0;
                            top: 0;
                            overflow-y:auto;
                        }
                    }
                    .hovnobook_code {
                        word-break: normal;
                        white-space: pre-line;
                        background-color: #f7f7f9;
                        font-family: monospace;
                        padding: 2rem;
                    }

                    .nt {
                        color: #2f6f9f;
                    }
                    .na {
                        color: #4f9fcf;
                    }
                    .s {
                        color: #d44950;
                    }
                    .js {
                        white-space: pre-wrap;
                    }
                </style>
                <link rel="stylesheet">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@style"/>
                    </xsl:attribute>
                </link>
            </head>
            <body class="hovnobook-body">
                <div class="hovnobook_tabs_container">
                    <xsl:for-each select="component">
                        <label class="hovnobook_tab_label">
                            <xsl:attribute name="for">
                                <xsl:text>hovnobook_tab</xsl:text>
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <xsl:value-of select="@name"/>
                        </label>
                    </xsl:for-each>
                </div>
                <main class="hovnobook_main">
                    <xsl:for-each select="component">
                        <input type="radio" name="tabs" class="hovnobook_tab">
                            <xsl:attribute name="id">
                                <xsl:text>hovnobook_tab</xsl:text>
                                <xsl:value-of select="position()" />
                            </xsl:attribute>
                            <xsl:if test="position() = 1">
                                <xsl:attribute name="checked">
                                    <xsl:text>checked</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                        </input>
                        <div class="hovnobook_content">
                            <xsl:attribute name="id">
                                <xsl:value-of select="../@name" />
                            </xsl:attribute>
                            <h1 class="hovnobook_h1">
                                <xsl:value-of select="@name"/>
                            </h1>
                            <xsl:for-each select="story">
                                <xsl:variable name="nodestring">
                                    <xsl:apply-templates select="code/*" mode="serialize"/>
                                </xsl:variable>
                                <xsl:variable name="syntax_highlighted">
                                    <xsl:apply-templates select="code/*" mode="highlight_syntax">
                                        <xsl:with-param name="level">0</xsl:with-param>
                                    </xsl:apply-templates>
                                </xsl:variable>
                                <h2 class="hovnobook_h2">
                                    <xsl:value-of select="name"/>
                                </h2>
                                <div class="hovnobook_html">
                                    <xsl:value-of select="$nodestring" disable-output-escaping="yes"/>
                                </div>
                                <div class="hovnobook_code">
                                    <xsl:value-of select="$syntax_highlighted" disable-output-escaping="yes"/>
                                </div>
                                <div class="hovnobook_html">
                                    <xsl:value-of select="description" disable-output-escaping="yes"/>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                </main>
                <script>
                    function processHtml(e) {
                        if (e.children.length === 0) {
                            console.log('processing html');
                            e.innerHTML = e.innerText;
                            var scripts = e.getElementsByTagName('script');
                            for (var s of scripts) {
                                eval(s.innerText);
                            }
                        }
                    }
                    window.onload = function() {
                        var collection = document.getElementsByClassName('hovnobook_html');
                        for (var e of collection) {
                            processHtml(e);
                        }
                        collection = document.getElementsByClassName('hovnobook_code');
                        for (e of collection)
                            processHtml(e);


                        var id = 'simulatedStyle';

                        var generateEvent = function(selector) {
                            var style = "";
                            for (var i in document.styleSheets) {
                                var rules = document.styleSheets[i].cssRules;
                                for (var r in rules) {
                                    if(rules[r].cssText &amp;&amp; rules[r].selectorText){
                                        if(rules[r].selectorText.indexOf(selector) > -1){
                                            var regex = new RegExp(selector,"g")
                                            var text = rules[r].cssText.replace(regex,"[data-hover=\"true\"]");
                                            style += text+"\n";
                                        }
                                    }
                                }
                            }
                            var el = document.createElement('style');
                            el.id = id;
                            el.innerHTML = style;
                            document.head.appendChild(el);
                        };

                        generateEvent(":hover");
                    };
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="*" mode="serialize">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:apply-templates select="@*" mode="serialize" />
        <xsl:choose>
            <xsl:when test="node()">
                <xsl:text>&gt;</xsl:text>
                <xsl:apply-templates mode="serialize" />
                <xsl:text>&lt;/</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> /&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@*" mode="serialize">
        <xsl:choose>
            <xsl:when test="name() = 'hover'">
                <xsl:text>data-hover="true"</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> </xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>="</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>"</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="text()" mode="serialize">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- syntax highlighting, todo  -->
    <xsl:template match="*" mode="highlight_syntax">
        <xsl:param name="level" />
        <xsl:variable name="tabs">
            <xsl:call-template name="dup">
                <xsl:with-param name="input"><xsl:text>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></xsl:with-param>
                <xsl:with-param name="count" select="$level" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$tabs"/>
        <xsl:text>&lt;span class="nt"&gt;<![CDATA[&lt;]]></xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&lt;/span&gt;</xsl:text>
        <xsl:apply-templates select="@*" mode="highlight_syntax" />
        <xsl:choose>
            <xsl:when test="node()">
                <xsl:text>&lt;span class="nt"&gt;<![CDATA[&gt;]]>&lt;/span&gt;&#xa;</xsl:text>

                <xsl:apply-templates mode="highlight_syntax">
                    <xsl:with-param name="parent" select="name()"/>
                    <xsl:with-param name="level" select="$level + 1"/>
                </xsl:apply-templates>


                <xsl:value-of select="$tabs"/>

                <xsl:text>&lt;span class="nt"&gt;<![CDATA[&lt;/]]></xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text><![CDATA[&gt;]]>&lt;/span&gt;&#xa;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&lt;span class="nt"&gt;<![CDATA[/&gt;]]>&lt;/span&gt;&#xa;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@*" mode="highlight_syntax">
        <xsl:if test="name() != 'hover'">
            <xsl:text> &lt;span class="na"&gt;</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>=&lt;/span&gt;</xsl:text>
            <xsl:text>&lt;span class="s"&gt;"</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>"&lt;/span&gt;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()" mode="highlight_syntax">
        <xsl:param name="parent" />
        <xsl:param name="level" />
        <xsl:variable name="tabs">
            <xsl:call-template name="dup">
                <xsl:with-param name="input"><xsl:text>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></xsl:with-param>
                <xsl:with-param name="count" select="$level" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$parent = 'script' or ($parent = 'style')">
                <xsl:text>&lt;div class="js"&gt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&lt;/div&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space() != ''">
                    <xsl:value-of select="$tabs"/>
                </xsl:if>
                <xsl:value-of select="normalize-space()"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="normalize-space() != ''">
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="dup">
        <xsl:param name="input"/>
        <xsl:param name="count" select="1"/>
        <xsl:choose>
            <xsl:when test="not($count) or not($input)" />
            <xsl:otherwise>
            <xsl:variable name="string" 
                            select="concat($input, $input, $input, $input, 
                                            $input, $input, $input, $input,
                                            $input, $input)"/>
            <xsl:choose>
                <xsl:when test="string-length($string) >= 
                                $count * string-length($input)">
                <xsl:value-of select="substring($string, 1, 
                                    $count * string-length($input))" />
                </xsl:when>
                <xsl:otherwise>
                <xsl:call-template name="dup">
                    <xsl:with-param name="input" select="$string" />
                    <xsl:with-param name="count" select="$count div 10" />
                </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>