<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.util.*"%>
<%
	String saveDirName    	= ParamUtil.getReqParameter(request.getParameter("saveDirName"));
%>
<html>
	<head>
		<title></title>

		<LINK REL="STYLESHEET" TYPE='text/css' HREF='board1.css'>
			<script language="javascript" src="DHTMLed.js"></script> <!-- 상수 정의를 위해 승배 추가-->
			<script language="javascript">
			
				<!--
				var idEdit;
				var bLoad = false;
				var gSel = null;
				//var bHeader = "<link rel=stylesheet href=../css/dotori.css type=text/css>\n";
				var bHeader = "";
				var cPicker = null;
				var sEditMode = "html"
				var public_description = new Editor();
				function Editor() {
					this.put_html = put_html;
					this.get_html = get_html;
					this.get_text = get_text;

					this.setColor = setColor;
					this.setBgColor = setBgColor;
					this.setFocus = setFocus;
					this.setIcons = setIcons;
					this.setLetter= setLetter;
					this.setImage = setImage;

					this.put_editmode = put_editmode;
					this.get_editmode = get_editmode;
				}

				function init() {
					idBox.style.visibility = '';
					document.onmousedown = mouseDown;

					idEdit = EditCtrl;
					idEdit.document.designMode = "On";
					initEditor();
					bLoad = true;
				}

				function initEditor() {
					idEdit.document.open();
					idEdit.document.write(bHeader);
					idEdit.document.close();

					//idEdit.document.body.style.fontSize = "10pt";
					//idEdit.document.body.style.fontFamily = "굴림";

					window.external.raiseEvent("onafterload", window.document);
				}

				function mouseDown(e) {
					if (event.button == 2) {
						alert("편집기에서는 마우스의 왼쪽 버튼만 사용됩니다.");
						return false;
					}

					if (event.srcElement.id=='toolbar' || event.srcElement.parentElement.id=='formatSelect') {
						if (idEdit.document.selection.type == 'none') {
							gSel = null;
						}
						else {
							gSel = idEdit.document.selection.createRange();
						}
						return false;
					}
					return true;
				}

				function put_html(str) {
					idEdit.document.body.innerHTML = str;
				}

				function get_html() {
					var sBgColor;

					removeMisc();

					if (sEditMode == "html") {
						sBgColor = "";
						if (idEdit.document.body.style.backgroundColor != "") {
							sBgColor = idEdit.document.body.style.backgroundColor;
						}
						else if (idEdit.document.body.bgColor != "") {
							sBgColor = idEdit.document.body.bgColor;
						}

						if (sBgColor != "") {
							return bHeader + "<div id=\"view\" bgcolor=\""+sBgColor+"\">\n" + idEdit.document.body.innerHTML + "</div>";
						}
						else {
							return bHeader + idEdit.document.body.innerHTML;
						}
					}
					else {
						return idEdit.document.body.innerText;
					}
				}

				function get_text() {
					removeMisc();

					return idEdit.document.body.innerText;
				}

				function setBgColor() {
					if (idEdit.document.all.view != null) {
						idEdit.document.body.bgColor = idEdit.document.all.view.bgcolor;
						idEdit.document.body.innerHTML = idEdit.document.all.view.innerHTML;
					}
				}

				function setFocus() {
					idEdit.focus();
				}

				function format(what, opt) {
					if (opt == "removeFormat") {
						what = opt;
						opt = null;
					}

					if (gSel != null) {
						gSel.select();
					}

					if (opt == null) {
						idEdit.document.execCommand(what);
					}
					else {
						idEdit.document.execCommand(what, "", opt);
					}

					idEdit.focus();
				}

				function getEl(sTag, start) {
					while ((start!=null) && (start.tagName!=sTag)) {
						start = start.parentElement;
					}
					return start;
				}

				function backColor(sColor) {
					if (idEdit.document.selection.type == "None") {
						format("backcolor", sColor)
					}
					else {
						var sel = idEdit.document.selection.createRange();
						sel.pasteHTML("<font style=background-color:" + sColor + ">" + sel.text + "</font>");
						sel.select();
					}

					idEdit.focus();
				}

				function colorPicker(which) {
					if (cPicker!=null && !cPicker.closed) {
						return;
					}
					whichCol = which;
					cPicker = window.open("color.html", "ColorPicker", "fullscreen=no,titlebar=no,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=520,height=460")

				}

				function setColor(col) {
					switch (whichCol) {
						case 0:
								if (col=='transparent')  {
									format('forecolor', '#c0c0c0');
								}
								else {
									format('forecolor', col);
								}
								break;
						case 1:
								backColor(col);
								break;
						case 2:
								alert("전체색상은 바꿀수 없습니다.");
								//idEdit.document.body.bgColor = col
								//removeMisc();
								break;
					}
				}

				function removeMisc() {
					var bodyTags = idEdit.document.body.all;
					for (i = bodyTags.tags("FONT").length - 1; i >= 0; i--) {
						if (bodyTags.tags("FONT")[i].style.backgroundColor == "#ffffff") {
							bodyTags.tags("FONT")[i].style.backgroundColor = ""
							if (bodyTags.tags("FONT")[i].outerHTML.substring(0, 6) == "<FONT>") {
								bodyTags.tags("FONT")[i].outerHTML = bodyTags.tags("FONT")[i].innerHTML;
							}
						}
					}
				}

				function get_editmode()
				{
					return sEditMode;
				}

				function put_editmode(sMode)
				{
					var tmp;

					if (sEditMode == sMode) {
						return;
					}

					sEditMode = sMode;

					if (sMode == "text") {
						disableEditBar(true);

						tmp = idEdit.document.body.outerHTML;
						idEdit.document.open();
						idEdit.document.write(bHeader + formatCode(tmp.replace(/&/g, "&amp;")));
						idEdit.document.close();
						EditCtrl.height = 310;
					}
					else {
						disableEditBar(false);

						tmp = "" + idEdit.document.body.innerText + "";
						idEdit.document.open();
						idEdit.document.write(tmp);
						idEdit.document.close();
						EditCtrl.height = 280;
					}

					//idEdit.document.body.style.fontSize = "10pt";
					//idEdit.document.body.style.fontFamily = "굴림";
					idEdit.focus();

					var s = idEdit.document.body.createTextRange();
					s.collapse(false);
					s.select();
				}

				function formatCode(s)
				{
					var str = "";
					var IN_TEXT = 1;
					var IN_ELEMENT = 2;
					var state = IN_TEXT;

					while (s.length > 0) {
						var endTagBreak, emptyTagBreak;

						if (state == IN_ELEMENT){
							var endIndex = s.indexOf(">");
							var endTag = (s.substring(0,1) == "/");

							if (endIndex != -1){
								str += s.substring(0, endIndex) + "&gt;</span>";
								if (endTag && endTagBreak || emptyTagBreak)
									str += "<br>";
									s = s.substring(endIndex+1, s.length);
									state=IN_TEXT;
							}
							else {
								str += s + "</span>";s="";
							}
						}
						else {
							var startIndex = s.indexOf("<");
							var endTags = new Array("P","DIV","H1","H2","H3","H4","H5","H6","BLOCKQUOTE","OL","LI","PRE","UL","TITLE","BODY","META","HEAD");
							var startTags = new Array("BR","HR","META","HTML","BODY","HEAD");

							if (startIndex != -1){
								var tagName;
								var nameStartIndex;
								var gtIndex = s.indexOf(">");
								var spaceIndex = s.indexOf(" ");
								var slashIndex = s.indexOf("/");

								endTagBreak = false;
								emptyTagBreak = false;
								if (slashIndex != -1 && slashIndex == startIndex+1)
									nameStartIndex = slashIndex+1;
								else
									nameStartIndex = startIndex+1;
								if (spaceIndex != -1 && spaceIndex > startIndex && spaceIndex < gtIndex)
									tagName = s.substring(nameStartIndex,spaceIndex);
								else if (gtIndex != -1)
									tagName = s.substring(nameStartIndex,gtIndex);
								else
									tagName = s.substring(nameStartIndex,s.length);

								for (var i = 0;i < endTags.length; i++){
									if (endTags[i] == tagName) {
										endTagBreak = true;
										break;
									}
								}

								for (var i = 0;i < startTags.length; i++) {
									if (startTags[i] == tagName) {
										emptyTagBreak = true;break;
									}
								}

								str += s.substring(0,startIndex) + "<span style='color:darkblue;'>&lt;";
								s = s.substring(startIndex+1,s.length);
								state=IN_ELEMENT;
							}
							else {
								str += s;
								s = "";
							}
						}
					}

					return str;
				}

				function disableEditBar(b)
				{
					if (b == true) {
						idBox.style.height = 0;
						idBox.style.display = "none";
					}
					else {
						idBox.style.height = 26;
						idBox.style.display = "block";
					}
				}

				function setIcons(str) {
					if (str != null){
						var sel = idEdit.document.selection.createRange();
							sel.pasteHTML("<img src=wysiwyg/icons/" + str + ".gif border=0>" );
							sel.select();
					}
					else {
						idEdit.focus();
					}
				}


				function setImage(str,edit_url,align,valign) {
					
					if (str != null){
						var sel = idEdit.document.selection.createRange();
							sel.pasteHTML("<img src='" + edit_url + str + "' border=0 vspace=4 hspace=4 align=" + align + " valign=" + valign + ">" );
							sel.select();
					}
					else {
						idEdit.focus();
					}
				}

				function setFlash(str) {
					if (str != null){
						var sel = idEdit.document.selection.createRange();
							sel.pasteHTML("<EMBED autostart=true autostart='false' AllowScriptAccess='bitom' src=upload_flash/"+str+" type=application/x-shockwave-flash>");
							sel.select();
					}
					else {
						idEdit.focus();
					}
				}

				function setLetter(str) {

					if (str != null){
						var sel = idEdit.document.selection.createRange();
							sel.pasteHTML(str);
							sel.select();
					}
					else {
						idEdit.focus();
					}
				}

				function OpenWin(URL,width,height) {
				  
					var str,width,height;
						str="'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,";
						str=str+"width="+width;
						str=str+",height="+height+"',top=150,left=250";
						wopen = window.open(URL,'remote',str);
						//showModalDialog(URL,"","font-family:Verdana; font-size:12;dialogWidth:265px; dialogHeight:445px;status:no;help:no;self-close:no;scroll:no" );
					}

				//-->
			</script>
			<script LANGUAGE="javascript" FOR="EditCtrl" EVENT="ContextMenuAction(itemIndex)">
				if (itemIndex == 0 ){

					format('copy');
				}
				else if (itemIndex == 1) {
					format ('cut');
				}
				else if (itemIndex == 2) {
					format('paste');
				}
				else if(itemIndex == 3) {
					EditCtrl.execCommand(DECMD_FONT);
				}
			</script>
			<script LANGUAGE="javascript" FOR="EditCtrl" EVENT="ShowContextMenu">
				var menuStrings = new Array();
				var menuStates = new Array();

					menuStrings[0] = "복사";
					menuStrings[1] = "잘라내기";
					menuStrings[2] = "붙여넣기";

				if (sEditMode == "html") {
						menuStrings[3] = "글꼴설정";
						menuStates[3] = OLE_TRISTATE_UNCHECKED;
					}
					menuStates[0] = OLE_TRISTATE_UNCHECKED;
					menuStates[1] = OLE_TRISTATE_UNCHECKED;
					menuStates[2] = OLE_TRISTATE_UNCHECKED;

					EditCtrl.SetContextMenu(menuStrings, menuStates);
			</script>
			<script for="EditCtrl" event="DocumentComplete()">
			</script>
	</head>
	<body leftmargin="15" topmargin="0" marginwidth="15" marginheight="0" onLoad="init();" class="wysiwygBG">
		<div id="idBox" style="border-right:#999999 1px solid;border-top:#999999 1px solid;background:#cdcdcd;margin-bottom: 3pt;overflow: hidden;border-left: #999999 1px solid;border-bottom: #999999 1px solid;height: 28px;width:575;text-align:left;visibility:visible">
			<table id="tb1" cellspacing="2" cellpadding="0" class="wysiwygTB">
				<tr>
					<td id="fontSelect" valign="middle" nowrap>
						<select tabindex="-1" onChange="format('fontname',this[this.selectedIndex].value);this.selectedIndex=0"
							id="select1" name="select1">
							<option selected>
							폰트
							<option value="바탕체">
							바탕체
							<option value="굴림체">
							굴림체
							<option value="돋움체">
							돋움체
							<option value="궁서체">
							궁서체
							<option value="arial">
							Arial
							<option value="impact">
							Impact
							<option value="times">
							Times
							<option value="verdana">
							Verdana
							<option value="sans-serif">
							Sans-serif
							<option value="courier">
							Courier
						</select>
					</td>
					<td id="sizeSelect" valign="middle" nowrap>
						<select tabindex="-1" onChange="format('fontSize',this[this.selectedIndex].text);this.selectedIndex=0"
							id="select2" name="select2">
							<option>
							크기
							<option>
							1
							<option>
							2
							<option>
							3
							<option>
							4
							<option>
							5
							<option>
							6
							<option>
							7
						</select>
					</td>
				</tr>
			</table>
			<div id="tb2" style="position:absolute;top:0px;left:160px;width:290px;border-style:none;padding-bottom:3px" onSelectStart="return false" onDragStart="return false">
				<script language="javascript">
					<!--
					var buttons = new Array(4, 23, 23, 23, 4, 23, 23, 23, 4, 23, 23, 23, 4, 23, 23, 4);
					var action = new Array("", "bold", "italic", "underline", "", "forecolor", "backcolor", "backgndcolor", "", "justifyleft", "justifycenter", "justifyright", "", "drawImage", "createLink", "");
					var tooltip = new Array("", "굵게", "기울임꼴", "밑줄", "", "글자색", "글바탕색", "바탕색", "", "왼쪽맞춤", "가운데맞춤", "오른쪽맞춤", "", "이미지삽입", "하이퍼링크", "");
					var left = 0;
					var s = "";


					for (var i = 0; i < buttons.length; i++) {
						s += "<span style='position:relative;height:26;width:" + buttons[i] + "'><span style='position:absolute;margin:0px;padding:0;height:26;top:0;left:0;width:" + (buttons[i]) + ";clip:rect(0 "+buttons[i]+" 25 "+0+");overflow:hidden'><img id=toolbar border=0 src='km_img/menu_icon.gif' style='position:absolute;top:0;left:-" + left + "' width=269 height=50"
						if (buttons[i] != 4) {
							s += " onMouseOver='this.style.top=-25' onMouseOut='this.style.top=0' onClick=\"";
							if (action[i]=="forecolor") {
								s += "colorPicker(0);this.style.top=0\" ";
							}
							else if (action[i]=="backcolor") {
								s += "colorPicker(1);this.style.top=0\" ";
							}
							else if (action[i]=="backgndcolor") {
								s += "colorPicker(2);this.style.top=0\" ";
							}
							else if (action[i]=="drawImage") {
								s += "OpenWin('imageUp.jsp?saveDirName=<%=saveDirName%>',260,220);this.style.top=0\" ";
							}
							else {
								s += "format('" + action[i] + "');this.style.top=0\" ";
							}
							s += "title=\"" + tooltip[i] + "\""
						}

						s += "></span></span>";
						left += buttons[i];
					}
					document.write(s);
					//-->
				</script>
			</div>
		</div>
		<script language="javascript">
				document.write("<iframe name=\"EditCtrl\" width=\"560\" height=\"280\"></iframe>")
		</script>
		<br>
		<img src="km_img/editor_view.gif" border="0" OnClick="put_editmode('html');"><img src="km_img/html_view.gif" border="0" OnClick="put_editmode('text')">
	</body>
</html>
