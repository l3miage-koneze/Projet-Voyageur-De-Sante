<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : cabinet.xsl
    Created on : 9 novembre 2022, 09:16
    Authors     : Zeinabou Bissi KONE - Sicong XU
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:cab="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    
    <!--.....................................MES PARAMETRES.......................................................-->
    
    
    <!--............Paramètre qui contient l'identifiant de l'infirmière................-->
    <xsl:param name="destinedId" select="001"/>
    
    
    <!--............Paramètre qui contient la date de la visite du jour....................-->
    <xsl:param name="dateVisite" select="'2015-12-08'"/>
    
    
    
    
    <!--................................MES VARIABLES......................................................--> 
    
    
    <!--...........Variable actes qui contient TOUS les noeuds ngap du document actes.xml..................-->
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    
    
    <!--..........Variable espace qui nous servira "d'espace" dans nos tableaux, listes, etc...............-->
    <xsl:variable name="espace" select="' '"/>
    
    
    <!--..........Variable visitesDuJour qui contient TOUS les noeuds visite correpondant à l'infirmière.......-->
     <xsl:variable name="visitesDuJour" select="//cab:patient/cab:visite[@intervenant=$destinedId]"/>
     
     
    <!--.........Variable prenomInfirmiere qui contient le prénom de l'infirmière dont l'identifiant est destinedId......-->
    <xsl:variable name="prenomInfirmiere" select="//cab:infirmier[@id=$destinedId]/cab:prénom/text()"/>
    
    
    <!--..........Variable nbPatientsAVisiter qui contient le nombre de tous les patients de l'infirmière........-->
    <xsl:variable name="nbPatientsAVisiter" select="count($visitesDuJour)"/>
    
    
    
     
     <!--........................Template qui génère et affiche la page de l'infirmière.......-->
     
    <!-- Affiche par exemple :
    Bonjour Annie,
    Aujourd'hui, vous avez 5 patients -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Page de l'infirmier/infirmière<xsl:value-of select="//cab:infirmier[@id=$destinedId]/cab:nom/text()"/>
                        <xsl:value-of select="//cab:infirmier[@id=$destinedId]/cab:prénom/text()"/>
                </title>
                <link rel="stylesheet" href="../css/ficheInfirmier.css"/>
                
                <script type="text/javascript">
                    function openFacture(prenom, nom, actes) {
                        var width  = 500;
                        var height = 300;
                        if(window.innerWidth) {
                            var left = (window.innerWidth-width)/2;
                            var top = (window.innerHeight-height)/2;
                        }
                        else {
                            var left = (document.body.clientWidth-width)/2;
                            var top = (document.body.clientHeight-height)/2;
                        }
                        var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                        factureText = "Facture pour : " + prenom + " " + nom;
                        factureWindow.document.write(factureText);
                    }
                </script>
            </head>
            
            <body>
                <div id="pageBody">
                    
                    <h1 class="title">Cabinet médical de Grenoble</h1> 
                    
                    <h2 class="sub-title">
                        <i>
                            Page de l'infirmier/infirmière     
                        </i>
                    </h2>
                    <hr/>
                    <p>
                        Bonjour <xsl:value-of select="$prenomInfirmiere"/><br/>

                        Aujourd'hui, vous avez <xsl:value-of select="$nbPatientsAVisiter"/> visite(s) ! 
                    </p>
                    <hr/>

                    <h3>
                        Patient(s) du jour :
                    </h3>
                    <div id="patientTable">
                        <xsl:apply-templates select="$visitesDuJour/.."/>
                    </div>
                </div>

            </body>
        </html>
    </xsl:template>

      
   
   <!--..... Cette template donnent les renseignements sur chaque patient de l'infirmière dans un tableau........... -->
   <!--..................Elle écrit son nom, son adresse et la liste des soins qu'il doit recevoir.................. -->
    
    <xsl:template match="cab:patient">
        <div id="patient">
            <h2>Patient N°<xsl:value-of select="position()"/>/<xsl:value-of select="$nbPatientsAVisiter"/></h2><br/>
        </div>
        
        <table border="1">
            
            <!--................Ligne d'en-tête du tableau.................-->
            
            <tr>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Adresse</th>
                <th>Soin(s)</th>
                <th>Date</th>
            </tr>
            
            <!--..........Lignes suivantes du tableau...................-->
            
            <tr>
                <td>
                    <xsl:value-of select="cab:nom/text()"/>
                </td>
                <td>
                    <xsl:value-of select="cab:prénom/text()"/>
                </td>
                <td>
                   <xsl:value-of select="cab:dresse/cab:numéro/text()"/>
                   <xsl:value-of select="$espace"/>
                   <xsl:value-of select="cab:adresse/cab:rue/text()"/>, 
                   <xsl:value-of select="cab:adresse/cab:codePostal/text()"/>
                   <xsl:value-of select="$espace"/>
                   <xsl:value-of select="cab:adresse/cab:ville/text()"/>
                </td>
                <td>
                    <xsl:apply-templates select="cab:visite[@intervenant=$destinedId]"/>
                </td>
                <td>
                    <xsl:value-of select="$dateVisite"/>
                </td>
            </tr> 
        </table>
        
        
        
        <!--.........Ajout du bouton Facture après le tableau de chaque patient.........-->
        
            <xsl:element name="input">
                <xsl:attribute name="type">submit</xsl:attribute>
                <xsl:attribute name="value">Facture</xsl:attribute>
                <xsl:attribute name="onclick">
                    openFacture('<xsl:value-of select="cab:nom/text()"/>', 
                    '<xsl:value-of select="cab:prénom/text()"/>', 
                    '<xsl:value-of select="cab:acte"/>')
                </xsl:attribute> 
            </xsl:element>
    </xsl:template> 
        
        
        
    <!--.........Cette template récupère la liste des actes d'une visite d'un patient..........-->
    
    <xsl:template match="cab:visite">
        <xsl:variable name="soin" select="cab:acte"/>
        <xsl:apply-templates select="cab:acte"/>
    </xsl:template>
    
    
    
    <!--..........Cette template écrit le soin lié à un acte dont l'id correspond à celui de l'acte du patient..... -->
    
    <xsl:template match="cab:acte">
        <xsl:variable name="identifiant" select="@id"/>
        <xsl:value-of select="$actes/act:actes/act:acte[@id=$identifiant]"/>
        <br/>
    </xsl:template>
    
</xsl:stylesheet>
