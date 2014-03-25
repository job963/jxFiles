[{*debug*}]
[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<script type="text/javascript">
  if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxorders" }]";
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

function change_all( name, elem )
{
    if(!elem || !elem.form) 
        return alert("Check Parameters");

    var chkbox = elem.form.elements[name];
    if (!chkbox) 
        return alert(name + " doesn't exist!");

    if (!chkbox.length) 
        chkbox.checked = elem.checked; 
    else 
        for(var i = 0; i < chkbox.length; i++)
            chkbox[i].checked = elem.checked;
}

</script>

    <h1>[{ oxmultilang ident="JXFILES_TITLE" }]</h1>
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
                <div style="float:left; cursor:default; border:1px [{if $aDir.path == $sSectionPath}]inset[{else}]outset[{/if}] gray; background-color:[{if $aDir.path == $sSectionPath}]#aaa[{else}]#e0e0e0[{/if}]; margin:4px; padding:4px; font-size:1.25em; font-weight:bold;" alt="[{$aDir.path}]" title="[{$aDir.path}]">
                    &nbsp;[{$aDir.title}]&nbsp;
                </div>
            </a>
        [{/foreach}]
        [{*<input type="submit" >*}]
    </form>    
    <br clear="all" />

    <form enctype="multipart/form-data" action="[{ $oViewConf->selflink }]" method="post">
        <h2>[{$sActTitle}]</h2>
        [{*ActPath: <b>[{$sActPath}]</b><br/>*}]
        <fieldset style="width:33%;">
            <input type="hidden" name="MAX_FILE_SIZE" value="100000">
            <input type="hidden" name="jxactdir" value="[{$sActPath}]">
            <input type="hidden" name="jxsortby" value="[{$sSortBy}]">
            <input type="file" name="uploadfile" size="40" maxlength="100000"><br />
            <input type="submit" name="Submit" value=" [{ oxmultilang ident="ARTICLE_EXTEND_FILEUPLOAD" }] " style="margin-top:8px;" />
        </fieldset>
    </form>    
        
        

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
            <td class="listfilter" style="[{$headStyle}]" align="center"><div class="r1"><div class="b1"><input type="checkbox" onclick="change_all('jxfiles_oxid[]', this)"></div></div></td>
        </tr>

        [{ assign var="actArtTitle" value="..." }]
        [{ assign var="actArtVar" value="..." }]
        [{assign var="iconPath" value=$oViewConf->getModuleUrl('jxfiles','out/admin/src/bg') }]
        [{foreach name=outer item=sFile from=$aFiles}]
            <tr>
                [{ cycle values="listitem,listitem2" assign="listclass" }]
                <td class="[{$listclass}]">
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
                    <a href="[{if $sFile.file}][{$sShopUrl}][{$sActPath}]/[{$sFile.name}][{else}]#[{/if}]" 
                       [{if !$sFile.file}]onclick="javascript:document.forms.jxfiles.jxsubdir.value='/'+'[{$sFile.name}]';document.forms.jxfiles.submit();"[{/if}]
                       [{if $sFile.file}]target="_blank"[{/if}] />
                    [{$sFile.name}]
                    </a>
                </td>
                <td class="[{$listclass}]">[{$sFile.date}]</td>
                <td class="[{$listclass}]" align="right">[{if $sFile.file}][{$sFile.size}][{/if}]&nbsp;</td>
                <td class="[{$listclass}]">
                    &nbsp;
                    [{if $sFile.type == "PNG" OR $sFile.type == "JPG" OR $sFile.type == "JPEG" OR $sFile.type == "GIF" OR $sFile.type == "ICO"}]
                        PNG[{ oxmultilang ident="JXFILES_IMAGEFILE" }]
                    [{elseif $sFile.type == "PDF"}]
                        PDF[{ oxmultilang ident="JXFILES_DOCUMENTFILE" }]
                    [{elseif !$sFile.file}]
                        [{ oxmultilang ident="JXFILES_DIRECTORY" }]
                    [{else}]
                        [{$sFile.type}][{ oxmultilang ident="JXFILES_FILE" }]
                    [{/if}]
                </td>
                <td class="[{$listclass}]" align="center"><input type="checkbox" name="jxfiles_oxid[]" value="[{$Order.orderartid}]"></td>
            </tr>
        [{/foreach}]
        [{*</tbody>*}]

        </table>
    </div>
</form>
