<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : fichePatient.xsl
    Created on : 12 novembre 2022, 23:06
     Authors     : Zeinabou Bissi KONE - Sicong XU
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:pat='http://www.ujf-grenoble.fr/l3miage/medical'
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    
    <!--......................................MES VARIABLES...............................................-->
    
    
    <!--..........Variable espace qui nous servira "d'espace" dans nos tableaux, listes, etc...............-->
    <xsl:variable name="espace" select="' '"/>
    
    <!--..........Variable qui stocke la valeur du sexe du patient.........................................-->
    <xsl:variable name="sexePatient" select="pat:patient/pat:sexe/text()" />
    
    
    
   <!--...................................Template principale qui génère la page de la fiche patient...............................................--> 
   <!--.......Elle affiche un formulaire qui renseigne l'état civil, l'adresse, l'intervenant et les soins d'un patient sur différents champs.......-->
    
    <xsl:template match="/">
        <html>
            <head>
                <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Page du patient
                    <xsl:value-of select="pat:patient/pat:nom/text()"/>
                    <xsl:value-of select="pat:patient/pat:prénom/text()"/>
                </title>
                <link rel="stylesheet" href="../css/fichePatient.css"/>
            </head>
            
            
            <body>
                
                <div id="corps">
                    <h1 id="title">Cabinet Infirmier de Grenoble</h1>
                    <h2>Fiche patient</h2>
                    <class id="information">
                        <form method="get">
                            
                            <!--.......Champ ETAT CIVIL.........-->
                            
                            <fieldset>
                                <table>
                                    <legend>
                                        <h3>ETAT CIVIL</h3>
                                    </legend>
                                    
                                    <!--..........NOM.........-->
                                    <tr>
                                        <td>Nom: </td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">nomPatient</xsl:attribute>
                                                <xsl:attribute name="name">nom</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:nom/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    <!--..........PRENOM.........-->
                                    <tr>
                                        <td>Prénom: </td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">prénomDuPatient</xsl:attribute>
                                                <xsl:attribute name="name">prénom</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:prénom/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                     <!--..........SEXE.........-->
                                    <tr>
                                        <td>Sexe :</td>
                                        <td>
                                            <!--....Ici, on fait une distinction de cas en fonction de la valeur du sexe.....-->
                                            
                                            <!--.....Le patient est de sexe M (homme).........-->
                                            <xsl:if test="'M'=$sexePatient">
                                                <input name="sex" type="checkbox" value="M" checked=""/>M
                                                <input name="sex" type="checkbox" value="F"/>F
                                            </xsl:if>
                                            
                                            <!--.......La patiente est de sexe F (femme).......-->
                                            <xsl:if test="'F'=$sexePatient">
                                                <input name="sex" type="checkbox" value="M"/>M
                                                <input name="sex" type="checkbox" value="F" checked=""/>F
                                            </xsl:if>                                          
                                        </td>
                                    </tr>
                                    
                                     <!--..........DATE DE NAISSANCE.........-->
                                    <tr>
                                        <td>Date de Naissance :</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="type">date</xsl:attribute>
                                                <xsl:attribute name="name">naissance</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:naissance/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    <!--..........NUMERO DE SECU.........-->
                                    <tr>
                                        <td>Numéro de SS:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">numéro</xsl:attribute>
                                                <xsl:attribute name="name">SECU</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:numéro/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            
                            
                            <!--................Champ ADRESSE..............-->
                            <fieldset>
                                <table>
                                    <legend>
                                        <h3>ADRESSE</h3>
                                    </legend>
                                    
                                    <!--.......ETAGE.........-->
                                    <tr>
                                        <td>Etage:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">EtagePatient</xsl:attribute>
                                                <xsl:attribute name="name">étage</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:adresse/pat:étage/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    <!--.......NUMERO........-->
                                    <tr>
                                        <td>Numéro:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">numéroPatient</xsl:attribute>
                                                <xsl:attribute name="name">numéro</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:adresse/pat:numéro/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    <!--........RUE.........-->
                                    <tr>
                                        <td>Rue:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">ruePatient</xsl:attribute>
                                                <xsl:attribute name="name">rue</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:adresse/pat:rue/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                     <!--.......VILLE........-->
                                    <tr>
                                        <td>Ville:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">villePatient</xsl:attribute>
                                                <xsl:attribute name="name">ville</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:adresse/pat:ville/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                     <!--.......CODE POSTAL........-->
                                    <tr>
                                        <td>Code postal:</td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">codePostalPatient</xsl:attribute>
                                                <xsl:attribute name="name">codePostal</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:adresse/pat:codePostal/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            
                            
                            <!--............Champ INTERVENANT...............-->
                            <fieldset>
                                <table>
                                    <legend>
                                        <h3>INTERVENANT</h3>
                                    </legend>
                                    
                                    <!--......NOM............-->
                                    <tr>
                                        <td>Nom : </td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">nomIntervenant</xsl:attribute>
                                                <xsl:attribute name="name">nom</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:visite/pat:intervenant/pat:nom/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    <!--.........PRENOM........-->
                                    <tr>
                                        <td>Prénom : </td>
                                        <td>
                                            <xsl:element name="input">
                                                <xsl:attribute name="id">prénomIntervenant</xsl:attribute>
                                                <xsl:attribute name="name">prénom</xsl:attribute>
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="pat:patient/pat:visite/pat:intervenant/pat:prénom/text()"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                    
                                    
                                    <!--...............Boutons de validation des informations..........-->
                                    <tr>
                                        <td>
                                            <input type="reset" value="Annuler"/>
                                        </td>
                                        <td>
                                            <input type="submit" value="Valider"/>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </form>
                    </class>
                    
                    
                    <!--...................................PARTIE VISITE............................................................-->
                
                    
                    <h3>
                        Nombre de visite(s) prévue(s) : 
                        <xsl:value-of select="count(pat:patient/pat:visite)"/>
                    </h3>
                    
                    <div>
                        
                        <!--.......Templates qui s'applique pour chaque element visite......... -->
                        
                        <xsl:apply-templates select="pat:patient/pat:visite"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>



    <!--.............Template qui contient les données de la visite d'un patient.....................-->
    
    
    <xsl:template match="pat:patient/pat:visite">
        <div>
            <h4>Date : 
                <xsl:value-of select="@date"/>
            </h4>
            
            <!--.............Liste des soins.............-->
            <ul>
                <xsl:apply-templates select="pat:acte"/>
            </ul>
        </div>
    </xsl:template>
    


    <!--....................Template qui liste tous les actes du patient............-->
    
    <xsl:template match="pat:acte">
        <li>
            <p>
               <xsl:value-of select="text()"/> 
            </p>
        </li>
    </xsl:template>

</xsl:stylesheet>
