<?xml version="1.0" encoding="UTF-8"?>


<!--
    Document   : patient_xml.xsl
    Created on : 12 novembre 2022, 23:06
     Authors     : Zeinabou Bissi KONE - Sicong XU
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:act='http://www.ujf-grenoble.fr/l3miage/actes'
                xmlns:pat='http://www.ujf-grenoble.fr/l3miage/medical'>
    
    <xsl:output method="xml"
                indent="yes"/>
    
    
    
    <!--..........................................MES PARAMETRES.........................................................-->
    
    
    <!--...............................Paramètre destniedName qui contient le nom du patient..............................-->
    <xsl:param name="destinedName" select="'Alécole'"/>
    
    
    
    
    
    <!--............Template qui génère et affiche la page du patient dont le nom est stocké dans la variable destinedName.......-->
    
    <xsl:template match="/">
        <xsl:apply-templates select="//pat:patient[pat:nom=$destinedName]"/>
    </xsl:template>
    
    
    
   
    <!--..................Template qui implémente le document xml : racine, node, etc......................-->
    
    <xsl:template match="pat:patient">
      
        <!--......RACINE : patient.......-->
        <patient>
            
            <!--......FILS 1 de patient : nom........-->
            <nom>
                <xsl:value-of select="pat:nom/text()"/>
            </nom>
            
            <!--.......FILS 2 de patient : prénom.......-->
            <prénom>
                <xsl:value-of select="pat:prénom/text()"/>
            </prénom>

            <!--.......FILS 3 de patient : sexe.......-->
            <sexe>
                <xsl:value-of select="pat:sexe/text()"/>
            </sexe>
            
            <!--.......FILS 4 de patient : naissance.......-->
            <naissance>
                <xsl:value-of select="pat:naissance/text()"/>
            </naissance>
            
            <!--.......FILS 5 de patient : numéro (SECU).......-->
            <numéro>
                <xsl:value-of select="pat:numéro/text()"/>
            </numéro>
            
            <!--.......FILS 6 de patient : adresse.......-->
            <adresse>
                <xsl:apply-templates select="pat:adresse"/>
            </adresse>
            
            <!--.......FILS 7 de patient: visite.......-->
            <xsl:apply-templates select="pat:visite"/>   
              
        </patient>
    </xsl:template>
    
    
    
    <!--..........Template adresse qui implémente l'élément adresse et ses sous-éléments................-->
    
    <xsl:template match="pat:adresse">
        
            <!--.......FILS 1 d'adresse : étage........--> 
            <étage>
                <xsl:value-of select="pat:étage/text()"/>
            </étage>
           
          
            <!--.......FILS 1 d'adresse: numéro.......-->
            <numéro>
                <xsl:value-of select="pat:numéro/text()"/>
            </numéro>
                
            <!--.......FILS 2 d'adresse: rue.......-->
            <rue>
                <xsl:value-of select="pat:rue/text()"/>
            </rue>
                
            <!--.......FILS 3 d'adresse: ville.......-->
            <ville>
                <xsl:value-of select="pat:ville/text()"/>
            </ville>
    
            <!--.......FILS 4 d'adresse: codePostal.......-->
            <codePostal>
                <xsl:value-of select="pat:codePostal/text()"/>
            </codePostal>
    </xsl:template>
    
    
    
    
    <!--..........Template adresse qui implémente l'élément visite et ses sous-éléments................-->
    
    <xsl:template match="pat:visite">
        
        <!--.......Element VISITE.......-->
        <xsl:element name="visite">
            
            <!--.....attribut DATE de l'élément VISITE.......-->
            <xsl:attribute name="date">
                <xsl:value-of select="@date"/>
            </xsl:attribute>
            
            <!--.......FILS 1 de visite : l'élément intervenant et ses sous-éléments : nom, prénom.........-->
            
            <!--..........Variable infirmierId qui contient l'id de l'intervenant du patient...............-->
            <xsl:variable name="infirmierId" select="@intervenant"/>
            
            <intervenant>
                <nom>
                    <xsl:value-of select="//pat:infirmier[@id=$infirmierId]/pat:nom/text()"/>
                </nom>
                <prénom>
                    <xsl:value-of select="//pat:infirmier[@id=$infirmierId]/pat:prénom/text()"/>
                </prénom>
            </intervenant>
            
            <!--.......FILS 2 de visite : acte.........-->
            <xsl:apply-templates select="pat:acte"/>
            
        </xsl:element>
    </xsl:template>
    
    
    
    <!--..........Template qui implémente le sous-élément acte de l'élement visite................-->
    
    <xsl:template match="pat:acte">
        
        <xsl:variable name="identifiant">
            <xsl:value-of select="@id"/>
        </xsl:variable>
        
        <xsl:variable name="actes" select="document('actes.xml', /)//act:acte[@id=$identifiant]/text()"/>
        <acte>
            <xsl:value-of select="$actes"/>
        </acte>
    </xsl:template>
</xsl:stylesheet>