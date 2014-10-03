[{*debug*}]
[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]
<link href="[{$oViewConf->getModuleUrl('jxfiles','out/admin/src/jxfiles.css')}]" type="text/css" rel="stylesheet">

<script type="text/javascript">
  if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxcustnews" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxfiles_menu" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }

function editThis( sID, sClass )
{
    [{assign var="shMen" value=1}]

    [{foreach from=$menustructure item=menuholder }]
      [{if $shMen && $menuholder->nodeType == XML_ELEMENT_NODE && $menuholder->childNodes->length }]

        [{assign var="shMen" value=0}]
        [{assign var="mn" value=1}]

        [{foreach from=$menuholder->childNodes item=menuitem }]
          [{if $menuitem->nodeType == XML_ELEMENT_NODE && $menuitem->childNodes->length }]
            [{ if $menuitem->getAttribute('id') == 'mxorders' }]

              [{foreach from=$menuitem->childNodes item=submenuitem }]
                [{if $submenuitem->nodeType == XML_ELEMENT_NODE && $submenuitem->getAttribute('cl') == 'admin_order' }]

                    if ( top && top.navigation && top.navigation.adminnav ) {
                        var _sbli = top.navigation.adminnav.document.getElementById( 'nav-1-[{$mn}]-1' );
                        var _sba = _sbli.getElementsByTagName( 'a' );
                        top.navigation.adminnav._navAct( _sba[0] );
                    }

                [{/if}]
              [{/foreach}]

            [{ /if }]
            [{assign var="mn" value=$mn+1}]

          [{/if}]
        [{/foreach}]
      [{/if}]
    [{/foreach}]

    var oTransfer = document.getElementById("transfer");
    oTransfer.oxid.value=sID;
    oTransfer.cl.value=sClass; /*'article';*/
    oTransfer.submit();
}

function showRenamePopup( filename )
{
    document.getElementById('popupRenameWin').style.display = 'block';
    document.getElementById('grayout').style.display = 'block';
    document.getElementById('jxoldfile').value = filename;
    document.getElementById('jxnewfile').value = filename;
}

function showDeletePopup( filename )
{
    document.getElementById('popupDeleteWin').style.display = 'block';
    document.getElementById('grayout').style.display = 'block';
    document.getElementById('jxfile').value = filename;
}

</script>

    <h1>[{ oxmultilang ident="JXFILES_TITLE" }]</h1>
    <div style="position:absolute;top:4px;right:8px;color:gray;font-size:0.9em;border:1px solid gray;border-radius:3px;">&nbsp;[{$sModuleId}]&nbsp;[{$sModuleVersion}]&nbsp;</div>
    <br clear="all" />

    
    <div id="popupRenameWin" class="jxpopupwin jxpopupfixed" style="display:none;">
        <div style="background:#3960ab;color:#fff;padding:4px;">
            <span style="font-weight:bold;">[{ oxmultilang ident="JXFILES_RENAME_TITLE" }]</span>
        </div>
        <div class="jxpopupclose" onclick="document.getElementById('popupRenameWin').style.display='none';document.getElementById('grayout').style.display='none';">
            <div style="height:3px;"></div>
            <span>X</span>
        </div>
        <div class="jxpopupcontent">
            <form name="jxrename" id="jxrename" action="[{ $oViewConf->selflink }]" method="post">
                [{ $oViewConf->hiddensid }]
                <input type="hidden" name="cl" value="jxfiles">
                <input type="hidden" name="fnc" value="jxrename">
                <input type="hidden" name="oxid" value="[{ $oxid }]">
                <input type="hidden" name="jxactdir" value="[{$sActPath}]">
                [{*
                <input type="hidden" name="jxsectiondir" value="[{$sSectionPath}]">
                <input type="hidden" name="jxsortby" value="[{$sSortBy}]">
                *}]

                <br />
                <table>
                    <tr>
                        <td><label for="jxoldfile">[{ oxmultilang ident="JXFILES_RENAME_OLDFILE" }]</label></td>
                        <td><input type="text" name="jxoldfile" id="jxoldfile" size="40" value="nofilename" disabled="disabled" /></td>
                    </tr>
                    <tr>
                        <td><label for="jxnewfile">[{ oxmultilang ident="JXFILES_RENAME_NEWFILE" }]</label></td>
                        <td><input type="text" name="jxnewfile" id="jxnewfile" size="40" autofocus /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right"> </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right"><button type="submit" onclick="document.getElementById('jxoldfile').disabled=false;">[{ oxmultilang ident="JXFILES_RENAME_BUTTON" }]</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    
    <div id="popupDeleteWin" class="jxpopupwin jxpopupfixed" style="display:none;">
        <div style="background:#3960ab;color:#fff;padding:4px;">
            <span style="font-weight:bold;">[{ oxmultilang ident="JXFILES_DELETE_TITLE" }]</span>
        </div>
        <div class="jxpopupclose" onclick="document.getElementById('popupDeleteWin').style.display='none';document.getElementById('grayout').style.display='none';">
            <div style="height:3px;"></div>
            <span>X</span>
        </div>
        <div class="jxpopupcontent">
            <form name="jxdelete" id="jxdelete" action="[{ $oViewConf->selflink }]" method="post">
                [{ $oViewConf->hiddensid }]
                <input type="hidden" name="cl" value="jxfiles">
                <input type="hidden" name="fnc" value="jxdelete">
                <input type="hidden" name="oxid" value="[{ $oxid }]">
                <input type="hidden" name="jxactdir" value="[{$sActPath}]">
                <input type="hidden" name="jxfile" id="jxfile" value="nofilename">
                <table width="80%">
                    <tr>
                        <td align="right"><span>This file will be deleted - Do want to to do this really?</span>
                    </tr>
                    <tr>
                        <td align="right">
                            <button type="submit" onclick="document.getElementById('jxoldfile').disabled=false;">[{ oxmultilang ident="JXFILES_DELETE_BUTTON" }]</button>
                            &nbsp;
                            <button type="reset" onclick="document.getElementById('popupDeleteWin').style.display='none';document.getElementById('grayout').style.display='none';">[{ oxmultilang ident="JXFILES_CANCEL_BUTTON" }]</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

    <div id="grayout" class="jxgrayout" style="display:none;"> </div>
    [{*<div id="execinfo" class="jxexecinfo">[{ oxmultilang ident="JXCMDBOARD_EXECUTING" }] <img src="[{$oViewConf->getModuleUrl('jxcmdboard','out/admin/src/img/progress.gif')}]"></div>*}]
    
    
    <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
        [{ $shop->hiddensid }]
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="cl" value="article" size="40">
        <input type="hidden" name="updatelist" value="1">
    </form>
        
    <form name="jxchdir" id="jxchdir" action="[{ $oViewConf->selflink }]" method="post">
        [{ $oViewConf->hiddensid }]
        <input type="hidden" name="cl" value="jxfiles">
        <input type="hidden" name="fnc" value="">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="jxactdir" value="[{$sActPath}]">
        <input type="hidden" name="jxsectiondir" value="[{$sSectionPath}]">
        <input type="hidden" name="jxsortby" value="[{$sSortBy}]">
        [{foreach name=dirs item=aDir from=$aDirs}]
            <a href="#" onclick="javascript:document.forms.jxchdir.jxactdir.value='[{$aDir.path}]';document.forms.jxchdir.jxsectiondir.value='[{$aDir.path}]';document.forms.jxchdir.submit();">
                <div class="[{if $aDir.path == $sSectionPath}]folderbtnpressed[{else}]folderbtn[{/if}]" [{*style="float:left; cursor:default; border:2px [{if $aDir.path == $sSectionPath}]inset[{else}]outset[{/if}] #ccc; background-image:linear-gradient(to top,[{if $aDir.path == $sSectionPath}]#ccc,#999[{else}]#bbb,#f8f8f8[{/if}]); background-color:[{if $aDir.path == $sSectionPath}]#aaa[{else}]#e0e0e0[{/if}]; margin:4px; padding:4px; font-size:1.25em; font-weight:bold; border-radius:3px;"*}] alt="[{$aDir.path}]" title="[{$aDir.path}]">
                    &nbsp;[{$aDir.title}]&nbsp;
                </div>
            </a>
        [{/foreach}]
        [{*<input type="submit" >*}]
    </form>    
    <br clear="all" />

    <form enctype="multipart/form-data" action="[{ $oViewConf->selflink }]" method="post">
        [{*<h2>[{$sActTitle}]</h2>*}]
        [{*ActPath: <b>[{$sActPath}]</b><br/>*}]
        [{assign var="maxFileSize" value="100000000"}]
        <fieldset style="width:30%;float:left;margin-right:20px;margin-bottom:20px;">
            [{*<legend>Upload</legend>*}]
            <input type="hidden" name="MAX_FILE_SIZE" value="[{$maxFileSize}]">
            <input type="hidden" name="jxactdir" value="[{$sActPath}]">
            <input type="hidden" name="jxsortby" value="[{$sSortBy}]">
            <input type="file" name="uploadfile" [{*size="80"*}] maxlength="[{$maxFileSize}]">[{*<br />*}]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" name="submit" value=" [{ oxmultilang ident="ARTICLE_EXTEND_FILEUPLOAD" }] " style="margin-top:8px;" />
        </fieldset>
    </form> 
        
        

    [{if $sUploadedFile != ""}]
        <div style="margin-left:10px; border:1px #00cc00 solid; border-radius:3px; padding:6px; background-color:#ddffdd; display:inline-block;">
            <span style="color:#00bb00;">[{ oxmultilang ident="JXFILES_UPLOADSUCCESS1" }] <b>&nbsp;[{$sUploadedFile}]&nbsp;</b> [{ oxmultilang ident="JXFILES_UPLOADSUCCESS2" }]</span><br />
        </div>
    [{/if}]
    [{if $iUploadError > 0}]
        <div style="margin-left:10px; border:1px #dd0000 solid; border-radius:3px; padding:6px; background-color:#ffdddd; display:inline-block;">
            <span style="color:#dd0000; font-size:1.1em; font-weight:bold;">[{ oxmultilang ident="JXFILES_ERRORONUPLOAD" }]</span><br />
            [{assign var="errText" value="JXFILES_UPLOADERROR"|cat:$iUploadError}]
            #[{$iUploadError}]: [{ oxmultilang ident=$errText }] (<a href="http://php.net/manual/de/features.file-upload.errors.php" target="_blank" style="font-weight:normal;text-decoration:underline;">Info</a>)
        </div>
    [{/if}]

<form name="jxfiles" id="jxfiles" action="[{ $oViewConf->selflink }]" method="post">
    <p>
        [{ $oViewConf->hiddensid }]
        <input type="hidden" name="cl" value="jxfiles">
        <input type="hidden" name="fnc" value="">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="jxactdir" value="[{$sActPath}]">
        <input type="hidden" name="jxsectiondir" value="[{$sSectionPath}]">
        <input type="hidden" name="jxsortby" value="[{$sSortBy}]">
        <input type="hidden" name="jxsubdir" value="">
    </p>
    
    <div id="liste">
        <table cellspacing="0" cellpadding="0" border="0" width="99%">
        <tr>
            [{ assign var="headStyle" value="border-bottom:1px solid #C8C8C8; font-weight:bold;" }]
            [{if $sActPath != $sSectionPath}]
                [{assign var="backLink" value="&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick=\"javascript:document.forms.jxfiles.jxsubdir.value='..';document.forms.jxfiles.submit();\">[..]</a>"}]
            [{else}]
                [{assign var="backLink" value=""}]
            [{/if}]
            <td class="listfilter first" style="[{$headStyle}]">
                <div class="r1"><div class="b1">
                    <a href="#" onclick="javascript:document.forms.jxfiles.jxsortby.value='name';document.forms.jxfiles.submit();">
                        [{ oxmultilang ident="JXFILES_FILENAME" }]
                    </a> [{$backLink}]
                </div></div>
            </td>
            <td class="listfilter" style="[{$headStyle}]">
                <div class="r1"><div class="b1">
                    <a href="#" onclick="javascript:document.forms.jxfiles.jxsortby.value='date';document.forms.jxfiles.submit();">
                        [{ oxmultilang ident="JXFILES_FILEDATE" }]
                    </a>
                </div></div>
            </td>
            <td class="listfilter" style="[{$headStyle}]">
                <div class="r1"><div class="b1">
                    <a href="#" onclick="javascript:document.forms.jxfiles.jxsortby.value='size';document.forms.jxfiles.submit();">
                        [{ oxmultilang ident="JXFILES_FILESIZE" }]
                    </a>
                </div></div>
            </td>
            <td class="listfilter" style="[{$headStyle}]"><div class="r1"><div class="b1">[{ oxmultilang ident="JXFILES_FILETYPE" }]</div></div></td>
            <td class="listfilter" style="[{$headStyle}]"><div class="r1"><div class="b1">[{ oxmultilang ident="JXFILES_FILERIGHTS" }]</div></div></td>
            <td class="listfilter" style="[{$headStyle}]" align="center"><div class="r1"><div class="b1">[{ oxmultilang ident="JXFILES_FILEACTION" }]</div></div></td>
        </tr>

        [{ assign var="actArtTitle" value="..." }]
        [{ assign var="actArtVar" value="..." }]
        [{assign var="iconPath" value=$oViewConf->getModuleUrl('jxfiles','out/admin/src/bg') }]
        [{foreach name=outer item=sFile from=$aFiles}]
            <tr>
                [{ cycle values="listitem,listitem2" assign="listclass" }]
                <td class="[{$listclass}]">
                    [{*&nbsp;*}]
                    [{if !$sFile.file}]
                        [{assign var="iconFile" value="folder_blue"}]
                    [{elseif  $sFile.type == "PNG" OR $sFile.type == "JPG" OR $sFile.type == "JPEG" OR $sFile.type == "GIF" OR $sFile.type == "ICO"}]
                        [{assign var="iconFile" value="colorize"}]
                    [{elseif $sFile.type == "PDF"}]
                        [{assign var="iconFile" value="pdf"}]
                    [{elseif $sFile.type == "TXT"}]
                        [{assign var="iconFile" value="ascii"}]
                    [{else}]
                        [{assign var="iconFile" value="empty"}]
                    [{/if}]
                    <img src="[{$iconPath}]/[{$iconFile}].png" style="position:relative;left:2px;top:3px;">&nbsp;
                    [{if $sFile.type == "PNG" OR $sFile.type == "JPG" OR $sFile.type == "JPEG" OR $sFile.type == "GIF" OR $sFile.type == "ICO"}]
                        <a class="thumbnail" href="#thumb"> [{*href="[{$sShopUrl}][{$sActPath}]/[{$sFile.name}]" target="_blank" />*}]
                            <span><img src="[{$sShopUrl}][{$sActPath}]/[{$sFile.name}]" style="max-height:144px;width:auto;"/></span>
                            [{$sFile.name}]
                        </a>
                    [{elseif $sFile.file}]
                        <a href="[{$sShopUrl}][{$sActPath}]/[{$sFile.name}]" target="_blank">
                            [{$sFile.name}]
                        </a>
                    [{else}]
                        <a href="#" onclick="javascript:document.forms.jxfiles.jxsubdir.value='/'+'[{$sFile.name}]';document.forms.jxfiles.submit();" />
                        [{$sFile.name}]
                        </a>
                    [{/if}]
                    
                    [{*<a href="[{if $sFile.file}][{$sShopUrl}][{$sActPath}]/[{$sFile.name}][{else}]#[{/if}]" 
                       [{if !$sFile.file}]onclick="javascript:document.forms.jxfiles.jxsubdir.value='/'+'[{$sFile.name}]';document.forms.jxfiles.submit();"[{/if}]
                       [{if $sFile.file}]target="_blank"[{/if}] />
                    [{$sFile.name}]
                    </a>*}]
                </td>
                <td class="[{$listclass}]">&nbsp;[{$sFile.date}]</td>
                <td class="[{$listclass}]" align="right">[{if $sFile.file}]<span title="[{$sFile.sizeOrg|number_format:0:",":"."}] Bytes">[{$sFile.sizeKB|number_format:0:",":"."}] KB</span>[{/if}]&nbsp;</td>
                <td class="[{$listclass}]">
                    &nbsp;
                    [{if $sFile.type == "PNG" OR $sFile.type == "JPG" OR $sFile.type == "JPEG" OR $sFile.type == "GIF" OR $sFile.type == "ICO"}]
                        [{$sFile.type}][{ oxmultilang ident="JXFILES_IMAGEFILE" }]
                    [{elseif $sFile.type == "PDF"}]
                        PDF[{ oxmultilang ident="JXFILES_DOCUMENTFILE" }]
                    [{elseif !$sFile.file}]
                        [{ oxmultilang ident="JXFILES_DIRECTORY" }]
                    [{else}]
                        [{$sFile.type}][{ oxmultilang ident="JXFILES_FILE" }]
                    [{/if}]
                </td>
                <td class="[{$listclass}]">&nbsp;[{if $sFile.writable}]W[{else}]R/O[{/if}]</td>
                <td class="[{$listclass}]" align="center">
                    [{if $sFile.file AND $sFile.writable}]
                        <a href="#" rel="nofollow" title="Rename" onclick="showRenamePopup('[{$sFile.name}]');">
                            <img src="[{$iconPath}]/button_edit.png" style="position:relative;left:2px;top:3px;">
                        </a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="#" rel="nofollow" title="Rename" onclick="showDeletePopup('[{$sFile.name}]');">
                            <img src="[{$iconPath}]/button_delete.png" style="position:relative;left:2px;top:3px;">
                        </a>
                    [{/if}]
                </td>
            </tr>
        [{/foreach}]
        [{*</tbody>*}]

        </table>
    </div>
</form>
