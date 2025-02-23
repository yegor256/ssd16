<?xml version="1.0"?>
<!--
 * SPDX-FileCopyrightText: Copyright (c) 2021 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="book">
    <item>
      <xsl:value-of select="title"/>
      <xsl:text> by </xsl:text>
      <xsl:value-of select="title"/>
    </item>
  </xsl:template>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
