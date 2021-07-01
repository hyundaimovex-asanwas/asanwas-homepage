<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 객실번호정보 Help 
 * 프로그램ID 	: Rm003H
 * J  S  P		: rm003h
 * 서 블 릿		: Rm003H
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-06-19
 * 기능정의		: 객실번호정보 조회 
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 :  
 * TODO			:
 * TODO         :
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>객실정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=S";
				ds2.Reset(); //영업장
			}
			function fnSelect() {
				fnSubSelect1();
			}
			 
			
			function fnSubSelect1() {
				ds1.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm003H?proType=S&dsType=1"
							+"&sUpjangSid="+ds2.namevalue(ds2.RowPosition, "upjang_sid")
							+"&sRoomNo="+sRoomNo.value;
				ds1.Reset();
		}
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "UPJANG_SID")  + ";" +                                                                           
									 ds1.namevalue(row, "UPJANG_NM")  + ";" +   
                                     ds1.namevalue(row, "FLOORS") + ";" +                                           
								 	 ds1.namevalue(row, "ROOM_NO")   + ";" +    
								 	 ds1.namevalue(row, "ROOM_TYPE_CD") + ";" + 
 								 	 ds1.namevalue(row, "ROOM_TYPE_NM") + ";" + 
								 	 ds1.namevalue(row, "ROOM_SID");            
				
			 	fnClose();
			}
			
			function fnClose() {
				window.close();
			}
			
			
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			fnAdd();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%=HDConstant.COMMENT_END%>


	</head>	
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:1px;width:270px;">
						<tr>
							<td height=30>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">객실번호정보조회</font>
							</td>
						</tr>
							<table width="250px" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" style="position:relative;left:2px;top:1px;">
							<tr bgcolor="#6f7f8d">
            					<td align=left class="text">&nbsp;영업장</td>
                                <td align=left bgcolor="#ffffff">&nbsp;	
							<%=HDConstant.COMMENT_START%>
									<object id=sUpjangSid classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=140  align=absmiddle >
										<param name=ComboDataID			value=ds2>
										<param name=SearchColumn		value="upjang_nm">
										<param name=ListExprFormat		value="upjang_nm^0^120">   
										<param name=BindColumn			value="upjang_sid">  
									</object>
							<%=HDConstant.COMMENT_END%>
							</tr>
							<tr bgcolor="#6f7f8d">
							<td align=left class="text">&nbsp;객실번호</td>
							<td align=left bgcolor="#ffffff">&nbsp;
								<input type="text" name="sRoomNo" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
						</table>
				</td>
				<td align=right width=50>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="고객을 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSubSelect1();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
							</td>
				</td>
			</tr>
		</table>
			</tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:5px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:240px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
							<c> Name='sid'				ID='upjang_sid'		HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=center show=false</c>
							<c> Name='업장명'				ID='upjang_nm'		HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=center </c>
							<c> Name='객실층' 			ID='floors'	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center</c>
							<c> Name='객실번호' 			ID='room_no'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center</c>
							<c> Name='객실타입' 			ID='room_type_cd'	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  LeftMargin=10 </c>
							<c> Name='객실타입명' 		ID='room_type_nm'	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  LeftMargin=10 </c>
							<c> Name='room_sid' 		ID='room_sid'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=159  LeftMargin=10 show=false</c>
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<!--  상태바 플레쉬  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>