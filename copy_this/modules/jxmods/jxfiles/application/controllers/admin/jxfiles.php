<?php

/*
 *    This file is part of the module jxFiles for OXID eShop Community Edition.
 *
 *    The module jxFiles for OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    The module jxFiles for OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      https://github.com/job963/jxFiles
 * @license   http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 * @copyright (C) Joachim Barthel 2012-2014 
 *
 */
 
class jxfiles extends oxAdminView
{
    protected $_sThisTemplate = "jxfiles.tpl";

    public function render()
    {
        parent::render();
        $oSmarty = oxUtilsView::getInstance()->getSmarty();
        $oSmarty->assign( "oViewConf", $this->_aViewData["oViewConf"]);
        $oSmarty->assign( "shop", $this->_aViewData["shop"]);
        
        $myConfig = oxRegistry::get("oxConfig");
        $sShopPath = $myConfig->getConfigParam("sShopDir");
                
        $sActPath = oxConfig::getParameter( "jxactdir" );
        $sSectionPath = oxConfig::getParameter( "jxsectiondir" );
        if (empty($sActPath)) {
            $sActPath = $myConfig->getConfigParam("sJxFilesDir1Path");
            $sActTitle = $myConfig->getConfigParam("sJxFilesDir1Title");
            $sSectionPath = $sActPath;
        }

        $sSubPath = oxConfig::getParameter( "jxsubdir" );
        if ($sSubPath == '..')
            $sActPath = dirname( $sActPath );
        elseif (!empty($sSubPath)) {
            $sParentPath = $sActPath;
            $sActPath .= $sSubPath;
        }
        
        $aDirs = array();
        for ($i=1; $i<=5; $i++) {
            if ($myConfig->getConfigParam("sJxFilesDir{$i}Path") != '') {
                array_push($aDirs, array(
                    'path' => $myConfig->getConfigParam("sJxFilesDir{$i}Path"),
                    'title' => $myConfig->getConfigParam("sJxFilesDir{$i}Title")
                ));
            }
        }
        
        /*$this->_logAction( " " );
        $this->_logAction( "error=".$_FILES["uploadfile"]["error"] );
        $this->_logAction( "upload=".$sShopPath.$sActPath.'/'.basename($_FILES['uploadfile']['name']) );*/
        if ($_FILES["uploadfile"]["tmp_name"] != '') {
            move_uploaded_file($_FILES["uploadfile"]["tmp_name"] ,$sShopPath.$sActPath.'/'.basename($_FILES['uploadfile']['name']));
            $oSmarty->assign("sUploadedFile",basename($_FILES['uploadfile']['name']));
        }
        
        $aFiles = $this->_getFiles($sShopPath.$sActPath);
        $sSortBy = oxConfig::getParameter( "jxsortby" );
        if (empty($sSortBy))
            $sSortBy = 'name';
        $aFiles = $this->_sortFiles($aFiles, $sSortBy );
        
        $oModule = oxNew('oxModule');
        $oModule->load('jxfiles');
        $oSmarty->assign("sModuleId",  $oModule->getId() );
        $oSmarty->assign("sModuleVersion", $oModule->getInfo('version') );
        
        $oSmarty->assign("iUploadError",$_FILES["uploadfile"]["error"]);
        $oSmarty->assign("sShopPath",$sShopPath);
        $oSmarty->assign("sShopUrl",$myConfig->getConfigParam("sShopURL"));
        $oSmarty->assign("aDirs",$aDirs);
        $oSmarty->assign("sActPath",$sActPath);
        $oSmarty->assign("sSectionPath",$sSectionPath);
        $oSmarty->assign("sActTitle",$sActTitle);
        $oSmarty->assign("sSortBy",$sSortBy);
        $oSmarty->assign("aFiles",$aFiles);

        return $this->_sThisTemplate;
    }
    
    
    
    private function _getFiles ($sPath) 
    {
        $d = dir($sPath);
        $aFiles = array();
        while (false !== ($entry = $d->read())) {
            if ( ($entry != '.') && ($entry != '..') ) {
                array_push ($aFiles, array(
                        'name' => $entry,
                        'date' => date( "Y-m-d  H:i:s", filemtime($sPath.'/'.$entry) ),
                        'sizeKB' => max(1,filesize($sPath.'/'.$entry)/1000),
                        'sizeOrg' => filesize($sPath.'/'.$entry),
                        'type' => strtoupper(substr(strrchr($entry, '.'), 1)),
                        'file' => (!is_dir($sPath.'/'.$entry)),
                        'writable' => is_writable($sPath.'/'.$entry)
                    ));
            }
        }
        $d->close();
        return $aFiles;
    }
    
    
    private function _sortFiles ($aFiles, $sCol)
    {
        $aSort = array();
        foreach ($aFiles as $key => $aRow) {
            if ($aRow['file'])
                $aSort[$key] = '1'.strtolower( $aRow[$sCol] );
            else
                $aSort[$key] = '0'.strtolower( $aRow[$sCol] );
        }
        if ($sCol == 'size') {
            $sortMode  = SORT_NUMERIC;
            $sortOrder = SORT_ASC;
        }
        elseif ($sCol == 'date') {
            $sortMode  = SORT_STRING;
            $sortOrder = SORT_ASC;
        }
        else {
            $sortMode  = SORT_STRING;
            $sortOrder = SORT_ASC;
        }
        array_multisort($aSort, $sortOrder, $sortMode, $aFiles);
        return $aFiles;
    }
    
    
    private function _logAction($sText)
    {
        $myConfig = oxRegistry::get("oxConfig");
        $sShopPath = $myConfig->getConfigParam("sShopDir");
        $sLogPath = $sShopPath.'/log/';
        
        $fh = fopen($sLogPath.'jxmods.log',"a+");
        fputs($fh,$sText."\n");
        fclose($fh);
    }

}

?>