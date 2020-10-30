<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">
  <html>
    <head>
      <meta charset="utf-8"></meta>
      <title>A list of Japanese Destinations</title>
      <!-- css styles -->
      <link rel="stylesheet" type="text/css" href="styles.css"></link>
    </head>
    <body>
      <header>
        <h1>A look back in time</h1>
        <h3>A list of Japanese Destinations</h3>
      </header>
      <table summary="interesting places to visit in Japan">
        <h5>Travel Japan: <a href="https://www.japan.travel/en/au/">Plan your trip here</a></h5>
        <h4>Early Japan Sites</h4>
        <thead>
          <tr>
            <th>Site</th>
            <th>Appearance Year</th>
            <th>Dynasty</th>
            <th>Existence</th>
            <th colspan="2">Size</th>
            <th>Overview</th>
            <th>Images</th>
            <th>Example</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="destination/site[./history/year &lt; 711]">
            <xsl:sort select="location" order="ascending" data-type="string" />
          </xsl:apply-templates>
        </tbody>
      </table>
      <table summary="Middle age Japanese Sites">
        <h4>Middle Age Japanese Sites</h4>
        <thead>
          <tr>
            <th>Site</th>
            <th>Appearance Year</th>
            <th>Dynasty</th>
            <th>Existence</th>
            <th colspan="2">Size</th>
            <th>Overview</th>
            <th>Images</th>
            <th>Example</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="destination/site[./history/year &gt; 710]">
            <xsl:sort select="year" order="descending" data-type="number" />
          </xsl:apply-templates>
        </tbody>
      </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="site">
  <tr>
    <xsl:apply-templates select="name[@language='english']"/>
    <xsl:apply-templates select="history"/>
    <xsl:choose>
      <xsl:when test="dimensions">
        <xsl:apply-templates select="dimensions"/>
      </xsl:when>
      <xsl:otherwise>
        <td>
          N/A
        </td>
        <td>
          N/A
        </td>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="links/overview[@type='detailed']"/>
    <xsl:apply-templates select="images"/>
    <xsl:apply-templates select="notes/note[@type='blurb']"/>
  </tr>
</xsl:template>

<xsl:template match="name[@language='english']">
  <td>
    <xsl:value-of select="."/>
  </td>
</xsl:template>

<xsl:template match="history">
  <td>
    <xsl:value-of select="year"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="year/@era"/>
  </td>
  <td>
    <xsl:value-of select="./dynasty"/>
  </td>
  <td>
    <xsl:choose>
      <xsl:when test="year[@range='end']">
        <xsl:value-of select="2020 - year[@range='start']"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="2020 - year[@range='start']"/>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:template>

<xsl:template match="dimensions">
  <td>
    approx. <xsl:value-of select="ceiling(./width * ./width)"/> m<sup>2</sup>
  </td>
  <td>
    avg. height <xsl:value-of select="sum(./height) div count(./height)"/>
  </td>
</xsl:template>

<xsl:template match="links/overview[@type='detailed']">
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="./@url"/>
      </xsl:attribute>
      <xsl:value-of select="translate(., 'w', 'W')"/>
    </a>
  </td>
</xsl:template>

<xsl:template match="images">
  <td><xsl:value-of select="count(./image)"/></td>
  <td>
    <a href=""><xsl:value-of select="image[@type='jpg'][position() = last()]"/></a>
  </td>
</xsl:template>

<xsl:template match="notes/note[@type='blurb']">
  <td>
    <xsl:value-of select="substring(.,1,75)"/>
    ...
  </td>
</xsl:template>

</xsl:stylesheet>

