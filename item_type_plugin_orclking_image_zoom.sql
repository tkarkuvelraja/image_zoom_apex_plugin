prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>42678949574119189
,p_default_application_id=>1009
,p_default_id_offset=>500534566193270241
,p_default_owner=>'FXO'
);
end;
/
 
prompt APPLICATION 1009 - DAMAC Leasing
--
-- Application Export:
--   Application:     1009
--   Name:            DAMAC Leasing
--   Date and Time:   15:43 Tuesday November 2, 2021
--   Exported By:     KARKUVELRAJA.T
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 410296102644798942
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     218250327993139
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/orclking_image_zoom
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(410296102644798942)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'ORCLKING.IMAGE.ZOOM'
,p_display_name=>'Image Zoom'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_image_zoom (',
'    p_item                IN apex_plugin.t_page_item,',
'    p_plugin              IN apex_plugin.t_plugin,',
'    p_value               IN VARCHAR2,',
'    p_is_readonly         IN BOOLEAN,',
'    p_is_printer_friendly IN BOOLEAN )',
'    RETURN apex_plugin.t_page_item_render_result ',
'    ',
'  AS  ',
'    l_result    apex_plugin.t_page_item_render_result;',
'    l_page_item_name    VARCHAR2(100);  ',
'    l_html  CLOB;',
'    l_img_link    apex_application_page_items.attribute_01%type := p_item.attribute_01;',
'    l_img_width    apex_application_page_items.attribute_02%type := p_item.attribute_02; ',
'    l_img_height    apex_application_page_items.attribute_03%type := p_item.attribute_03;',
'    l_glass_color    apex_application_page_items.attribute_05%type := p_item.attribute_05;',
'    l_glass_size    apex_application_page_items.attribute_06%type := p_item.attribute_06;',
'    l_glass_width NUMBER;',
'    l_glass_height NUMBER;',
'    l_my_image VARCHAR2(4000);',
'    l_my_result VARCHAR2(4000);',
'    l_image_result VARCHAR2(4000);',
'    ',
'  BEGIN',
'    -- Debug information (if app is being run in debug mode)',
'    IF apex_application.g_debug THEN',
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,',
'                                        p_page_item             => p_item,',
'                                        p_value                 => p_value,',
'                                        p_is_readonly           => p_is_readonly,',
'                                        p_is_printer_friendly   => p_is_printer_friendly);',
'    END IF;',
'    ',
'    -- handle read only and printer friendly',
'    IF p_is_readonly OR p_is_printer_friendly THEN',
'      -- omit hidden field if necessary',
'      apex_plugin_util.print_hidden_if_readonly (p_item_name             => p_item.name,',
'                                                 p_value                 => p_value,',
'                                                 p_is_readonly           => p_is_readonly,',
'                                                 p_is_printer_friendly   => p_is_printer_friendly);',
'      -- omit display span with the value',
'      apex_plugin_util.print_display_only (p_item_name          => p_item.NAME,',
'                                           p_display_value      => p_value,',
'                                           p_show_line_breaks   => FALSE,',
'                                           p_escape             => TRUE, -- this is recommended to help prevent XSS',
'                                           p_attributes         => p_item.element_attributes);',
'    ELSE',
'      -- Not read only',
'      -- Get name. Used in the "name" form element attribute which is different than the "id" attribute ',
'      l_page_item_name := apex_plugin.get_input_name_for_page_item (p_is_multi_value => FALSE);',
'',
'      IF l_glass_size = ''S'' THEN -- Small',
'         l_glass_width := 40;',
'         l_glass_height := 40;',
'      elsIF l_glass_size = ''M'' THEN -- Medium',
'         l_glass_width := 60;',
'         l_glass_height := 60;',
'      elsIF l_glass_size = ''L'' THEN -- Large',
'         l_glass_width := 80;',
'         l_glass_height := 80;    ',
'      end if;         ',
'      ',
'       IF l_glass_color = ''B'' THEN -- Black',
'         l_glass_color := ''#000'';',
'      elsIF l_glass_color = ''W'' THEN -- White',
'         l_glass_color := ''white'';',
'      elsIF l_glass_color = ''D'' THEN -- Default',
'         l_glass_color := ''#d4d4d4'';   ',
'      end if; ',
'      ',
unistr('      l_my_image := ''<img id="myimage_''||l_page_item_name||''" src="''||nvl(l_img_link,''http://2.bp.blogspot.com/-g4u7SML5N1Q/X9nObb_hJzI/AAAAAAAAXjU/lKdcY4WSp7Iq0\20261600/purepng.com-oracle-logologobrand-logoiconslogos-251519939816xngul.png'')||''" width="')
||'''||nvl(l_img_width,300)||''" height="''||nvl(l_img_height,240)||''">'';',
'l_my_result := ''<div id="myresult_''||l_page_item_name||''" class="img-zoom-result"></div>'';',
'',
'',
'l_image_result := ''<div class="img-zoom-container">',
'  <table> <tr> <td> ''||l_my_image||''</td>',
'  <td>''||l_my_result||''</td></tr></table>',
'</div>'';',
'',
'      -- Print Image Magnifier Glass',
'      ',
'      l_html := ''<!DOCTYPE html>',
'<html>',
'<head>',
'<meta name="viewport" content="width=device-width, initial-scale=1.0">',
'<style>',
'* {box-sizing: border-box;}',
'',
'.img-zoom-container {',
'  position: relative;',
'}',
'',
'#myimage {width: ''||nvl(l_img_width,300)||''px;',
'              height: ''||nvl(l_img_height,240)||''px;',
'                     }',
'.img-zoom-lens {',
'  position: absolute;',
'  border: 1px solid ''||nvl(l_glass_color,''#d4d4d4'')||'';',
'  /*set the size of the lens:*/',
'      width: ''||nvl(l_glass_width,40)||''px;',
'              height: ''||nvl(l_glass_height,40)||''px;',
'}',
'',
'.img-zoom-result {',
'  border: 1px solid #d4d4d4;',
'  /*set the size of the result div:*/',
' width: ''||nvl(l_img_width,300)||''px;',
'              height: ''||nvl(l_img_height,240)||''px;',
'}',
'</style>',
'<script>',
'function imageZoom(imgID, resultID) {',
'  var img, lens, result, cx, cy;',
'  img = document.getElementById(imgID);',
'  result = document.getElementById(resultID);',
'  /*create lens:*/',
'  lens = document.createElement("DIV");',
'  lens.setAttribute("class", "img-zoom-lens");',
'  /*insert lens:*/',
'  img.parentElement.insertBefore(lens, img);',
'  /*calculate the ratio between result DIV and lens:*/',
'  cx = result.offsetWidth / lens.offsetWidth;',
'  cy = result.offsetHeight / lens.offsetHeight;',
'  /*set background properties for the result DIV:*/',
'  result.style.backgroundImage = "url(''||''''||''" + img.src + "''||''''||'')";',
'  result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";',
'  /*execute a function when someone moves the cursor over the image, or the lens:*/',
'  lens.addEventListener("mousemove", moveLens);',
'  img.addEventListener("mousemove", moveLens);',
'  /*and also for touch screens:*/',
'  lens.addEventListener("touchmove", moveLens);',
'  img.addEventListener("touchmove", moveLens);',
'  function moveLens(e) {',
'    var pos, x, y;',
'    /*prevent any other actions that may occur when moving over the image:*/',
'    e.preventDefault();',
'    /*get the cursor''''s x and y positions:*/',
'    pos = getCursorPos(e);',
'    /*calculate the position of the lens:*/',
'    x = pos.x - (lens.offsetWidth / 2);',
'    y = pos.y - (lens.offsetHeight / 2);',
'    /*prevent the lens from being positioned outside the image:*/',
'    if (x > img.width - lens.offsetWidth) {x = img.width - lens.offsetWidth;}',
'    if (x < 0) {x = 0;}',
'    if (y > img.height - lens.offsetHeight) {y = img.height - lens.offsetHeight;}',
'    if (y < 0) {y = 0;}',
'    /*set the position of the lens:*/',
'    lens.style.left = x + "px";',
'    lens.style.top = y + "px";',
'    /*display what the lens "sees":*/',
'    result.style.backgroundPosition = "-" + (x * cx) + "px -" + (y * cy) + "px";',
'  }',
'  function getCursorPos(e) {',
'    var a, x = 0, y = 0;',
'    e = e || window.event;',
'    /*get the x and y positions of the image:*/',
'    a = img.getBoundingClientRect();',
'    /*calculate the cursor''''s x and y coordinates, relative to the image:*/',
'    x = e.pageX - a.left;',
'    y = e.pageY - a.top;',
'    /*consider any page scrolling:*/',
'    x = x - window.pageXOffset;',
'    y = y - window.pageYOffset;',
'    return {x : x, y : y};',
'  }',
'}',
'</script>',
'</head>',
'<body>'' ||l_image_result||''',
'',
'<script>',
'// Initiate zoom effect:',
'imageZoom("myimage_''||l_page_item_name||''", "myresult_''||l_page_item_name||''");',
'</script>',
'',
'</body>',
'</html>',
''';',
'      ',
'      l_result.is_navigable := FALSE;',
'    END IF; ',
'    sys.htp.p(l_html);',
'    RETURN l_result;',
'  END render_image_zoom;',
'  '))
,p_api_version=>1
,p_render_function=>'render_image_zoom'
,p_standard_attributes=>'VISIBLE:ELEMENT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/tkarkuvelraja/image_zoom_apex_plugin'
,p_files_version=>8
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(410305917786851067)
,p_plugin_id=>wwv_flow_api.id(410296102644798942)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Img. Link'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'http://2.bp.blogspot.com/-g4u7SML5N1Q/X9nObb_hJzI/AAAAAAAAXjU/lKdcY4WSp7Iq04B_k4k3qzCGRi3mUXb6QCK4BGAYYCw/s1600/purepng.com-oracle-logologobrand-logoiconslogos-251519939816xngul.png'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(410306442872852053)
,p_plugin_id=>wwv_flow_api.id(410296102644798942)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Img. Width'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'300'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(410306971762852600)
,p_plugin_id=>wwv_flow_api.id(410296102644798942)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Img. Height'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'240'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(405429330754728295)
,p_plugin_id=>wwv_flow_api.id(410296102644798942)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Glass Color'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'D'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(405429962720728886)
,p_plugin_attribute_id=>wwv_flow_api.id(405429330754728295)
,p_display_sequence=>10
,p_display_value=>'Black'
,p_return_value=>'B'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(405430342617729304)
,p_plugin_attribute_id=>wwv_flow_api.id(405429330754728295)
,p_display_sequence=>20
,p_display_value=>'White'
,p_return_value=>'W'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(230326814227294567)
,p_plugin_attribute_id=>wwv_flow_api.id(405429330754728295)
,p_display_sequence=>30
,p_display_value=>'Default'
,p_return_value=>'D'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(405430947821731270)
,p_plugin_id=>wwv_flow_api.id(410296102644798942)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Glass Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'M'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(405431509903731716)
,p_plugin_attribute_id=>wwv_flow_api.id(405430947821731270)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'S'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(405431969023732256)
,p_plugin_attribute_id=>wwv_flow_api.id(405430947821731270)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'M'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(405432374712732715)
,p_plugin_attribute_id=>wwv_flow_api.id(405430947821731270)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'L'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
