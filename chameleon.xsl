<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system=""/>
    <xsl:template match="/chameleon">

        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <title>
                    Component system
                </title>
                <style>
                    html {
                        font-size: 62.5%;
                    }

                    body {
                        font-size: 1.6rem;
                        font-family: sans-serif;
                    }

                    html,
                    body {
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
                        color: #333;
                        cursor: pointer;
                        user-select: none;
                    }

                    .hovnobook_tab_label:hover {
                        background: rgba(0, 0, 0, 0.2);
                        color: #2652CC;
                    }

                    .hovnobook_tabs_container {
                        position: relative;
                        width: 100%;
                        background: #fafafa;
                        border-right: 1px solid rgba(0,0,0,.07);
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
                            max-width: 800px;
                            margin: 0 auto;
                        }

                        .hovnobook_tabs_container {
                            width: 300px;
                            position: fixed;
                            left: 0;
                            bottom: 0;
                            top: 0;
                            overflow-y:auto;
                        }
                    }
                    .hovnobook_code {
                        word-break: normal;
                        background-color: #f7f7f9;
                        padding: 2rem;
                        border-radius: .8rem;
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
                        white-space: pre;
                    }
                </style>
                <style>
                    <xsl:for-each select="component">
                        <xsl:text>#hovnobook_tab</xsl:text>
                        <xsl:value-of select="position()"/>
                        <xsl:text>:checked ~ .hovnobook_tabs_container > .hovnobook_tab_label</xsl:text>
                        <xsl:value-of select="position()"/>
                        <xsl:if test="position() != count(../component)">
                            <xsl:text>,&#xa;</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>
                        {
                            background-color: blue;
                            color: white;
                        }
                    </xsl:text>
                    <xsl:for-each select="component">
                        <xsl:text>#hovnobook_tab</xsl:text>
                        <xsl:value-of select="position()"/>
                        <xsl:text>:checked ~ .hovnobook_main > .hovnobook_content</xsl:text>
                        <xsl:value-of select="position()"/>
                        <xsl:if test="position() != count(../component)">
                            <xsl:text>,&#xa;</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>
                        {
                            display: block;
                        }
                    </xsl:text>
                </style>
                <xsl:value-of select="styles" disable-output-escaping="yes"/>
                <style id="simulatedStyle">
                </style>
                <style id="body-styles">
                </style>
            </head>
            <body>
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
                </xsl:for-each>
                <div class="hovnobook_tabs_container">
                    <xsl:for-each select="component">
                        <label>
                            <xsl:attribute name="for">
                                <xsl:text>hovnobook_tab</xsl:text>
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">
                                <xsl:text>hovnobook_tab_label hovnobook_tab_label</xsl:text>
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <xsl:value-of select="name"/>
                        </label>
                    </xsl:for-each>
                </div>
                <main class="hovnobook_main">
                    <xsl:for-each select="component">
                        <xsl:variable name="parent-position" select="position()" />
                        <div>
                            <xsl:attribute name="id">
                                <xsl:text>hovnobook_content</xsl:text>
                                <xsl:value-of select="position()" />
                            </xsl:attribute>
                            <xsl:attribute name="class">
                                <xsl:text>hovnobook_content hovnobook_content</xsl:text>
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <xsl:for-each select="link">
                                <link>
                                    <xsl:if test="$parent-position != 1">
                                        <xsl:attribute name="disabled">
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="@title"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@href"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="media">
                                        <xsl:value-of select="@media"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="rel">
                                        <xsl:value-of select="@rel"/>
                                    </xsl:attribute>
                                </link>
                            </xsl:for-each>
                            <h1 class="hovnobook_h1">
                                <xsl:value-of select="name"/>
                            </h1>
                            <xsl:value-of select="description"/>
                            <xsl:for-each select="story">
                                <xsl:variable name="nodestring">
                                    <xsl:apply-templates select="code/*" mode="serialize"/>
                                </xsl:variable>
                                <xsl:variable name="syntax_highlighted">
                                    <xsl:apply-templates select="code/*" mode="highlight_syntax">
                                        <xsl:with-param name="level">0</xsl:with-param>
                                    </xsl:apply-templates>
                                </xsl:variable>
                                <xsl:if test="name">
                                    <h2 class="hovnobook_h2">
                                        <xsl:value-of select="name"/>
                                    </h2>
                                </xsl:if>
                                <div class="hovnobook_html">
                                    <xsl:value-of select="$nodestring" disable-output-escaping="yes"/>
                                </div>
                                <pre class="hovnobook_code">
                                    <xsl:value-of select="$syntax_highlighted" disable-output-escaping="yes"/>
                                </pre>
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

                        /* adds [data-hover="true"] styles to enable hover="true" */
                        var generateEvent = function(selector, link) {
                            var style = "";
                            for (var s of document.styleSheets) {
                                if (link &amp;&amp; s.href !== link.href)
                                    continue;
                                try {
                                    console.log(s);
                                    var rules = s.cssRules;
                                    for (var r in rules) {
                                        if(rules[r].cssText &amp;&amp; rules[r].selectorText){
                                            if(rules[r].selectorText.indexOf(selector) > -1){
                                                var regex = new RegExp(selector,"g")
                                                var text = rules[r].cssText.replace(regex,"[data-hover=\"true\"]");
                                                style += text+"\n";
                                            }
                                        }
                                    }
                                } catch (e) {
                                    
                                }
                            }

                            var el;
                            if (link) {
                                el = document.getElementById('body-styles');
                            } else {
                                el = document.getElementById('simulatedStyle');
                            }
                            el.innerHTML = style;
                        };


                        var checkboxes = document.getElementsByName('tabs');
                        for (var cb of checkboxes) {
                            cb.addEventListener('change', function(e) {
                                //disable old styles
                                var contents = document.getElementsByClassName('hovnobook_content');
                                for ( var c of contents) {
                                    var links = c.getElementsByTagName('link');
                                    for (var l of links ) {
                                        l.disabled = true;
                                    }
                                }

                                var id = e.target.id;
                                var contentId = 'hovnobook_content' + id.substring('hovnobook_tab'.length);
                                var content = document.getElementById(contentId);
                                var links = content.getElementsByTagName('link');
                                for (var link of links) {
                                    link.disabled = false;
                                    link.addEventListener('load', function() {
                                        generateEvent(":hover", link)
                                    });
                                }
                            });
                        }

                        generateEvent(":hover");
                    };
                </script>
                <xsl:value-of select="scripts" disable-output-escaping="yes"/>
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
                <xsl:with-param name="input"><xsl:text>    </xsl:text></xsl:with-param>
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
                <xsl:with-param name="input"><xsl:text>    </xsl:text></xsl:with-param>
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