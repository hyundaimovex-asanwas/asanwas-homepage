<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 인감관리자등록
+ 프로그램 ID	: a400110.jsp
+ 기 능 정 의	: 인감관리자등록
+ 최 초 이 력	: 2017.04.03 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400110_s1, a400110_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

    gcra_usegb_0.codevalue ="";	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400110_s1?v_str1="+gcem_empno_0.text
			                                                            +"&v_str2="+gcem_empnmk_0.text
			                                                            +"&v_str3="+gcra_usegb_0.codevalue;
   //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();	
	gcra_usegb.CodeValue="T";	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400110_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
		
    //필수항목 체크 
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){
			
			if(gcds_data.namevalue(i,"EMPNO") == ""){ 			
				alert("관리자사번을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"EMPNMK") == ""){
				alert("관리자성명을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"S_DATE") == ""){ 				
				alert("시작일자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"E_DATE") == ""){ 				
				alert("종료일자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"USEGB") == ""){ 				
				alert("사용유무를 입력하세요.");
				return false;
			}
			
		}
	} 
	
	return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}

<%	
/******************************************************************************
	Description : 삭제
******************************************************************************/
%>
function ln_Delete(){
		
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.KeyValue = "Account.a400110_t1(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400110_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		return ln_Query();
	}
	else gcds_data.undo(gcds_data.rowposition);
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

<%
/******************************************************************************
Description : 관리자팝업 
******************************************************************************/
%>
function ln_Popup_Empno_0(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_empno_0.text    = arrParam[1];
		gcem_empnmk_0.text   = arrParam[0];
	}else{
		gcem_empno_0.text="";
		gcem_empnmk_0.text="";
	}
}


<%
/******************************************************************************
Description : 관리자팝업 
******************************************************************************/
%>
function ln_Popup_Empno(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_empno.text    = arrParam[1];
		gcem_empnmk.text   = arrParam[0];
	}else{
		gcem_empno.text="";
		gcem_empnmk.text="";
	}
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a400110_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
	 	<td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" >검색</td>
			<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">관리자</td>
			<td width="400px"  class="tab18"  align=left  >
		    	<comment id="__NSID__">
				<object id=gcem_empno_0 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
					<param name=Text		  value="">
					<param name=Alignment	  value=0>
					<param name=Border		  value=true>
					<param name=Format		  value="#######">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="false">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr>
		    	
		    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Empno_0()">
		    	
		    	<comment id="__NSID__">
				<object  id=gcem_empnmk_0   classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language			value=1>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">사용유무</td>
			<td class="tab18" >&nbsp;
				<comment id="__NSID__">
				<object id=gcra_usegb_0 classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:175px;height:20px" >
					<param name=Cols		value="3">
					<param name=Format	value="T^사용,F^미사용,^전체">
				</object></comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		
		</table>
		</td>
	</tr>	
	<tr>
		<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
						<td ALIGN=LEFT VALIGN=TOP>
							<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_pyo style="WIDTH:650px;HEIGHT:425px;border:1 solid #777777;display:block;" viewastext>
	 						 <PARAM NAME="DataID"		VALUE="gcds_data">
							 <PARAM NAME="BorderStyle"  VALUE="0">
							 <PARAM NAME="Indwidth"		VALUE="0">
							 <PARAM NAME="Fillarea"		VALUE="true">
							 <PARAM NAME="ColSizing"	VALUE="true">
							 <param name="sortview"     value=left>
						     <PARAM NAME="Format"		VALUE="  
								<FC>ID=CurRow,	     Name=NO,	        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false Value={CurRow}</FC>
								<FC>ID=EMPID	     Name=관리자ID,	   	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </FC>
								<FC>ID=EMPNO	     Name=사번,	    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </FC>
								<C> ID=EMPNMK,	     Name=성명,  	    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=S_DATE,		 Name=시작일, 		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
								<C> ID=E_DATE,		 Name=종료일,	    	width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
								<C> ID=USEGB,	     Name=사용유무,	    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  EditStyle=Combo,  Data='T:사용,F:미사용'</C>
								<C> ID=REMARK,	     Name=적요,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
							">
						 	</object></comment><script>__ws__(__NSID__);</script> 
						</td>
				  	</tr>
				 </table>
			</td>
			<td>
				<!--입력창 -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:346px;height:425px;border:1 solid #708090;">
				
				   <tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>관리자ID</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_empid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:60px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>관리자사번<font size="2" color="red" >(*)</font></nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="#######">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Empno()">
					    	<comment id="__NSID__">
							<object  id=gcem_empnmk classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:150px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language	  value=1>
								<param name=Enable		  value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>시작일자<font size="2" color="red" >(*)</font></nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_s_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_s_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>종료일자<font size="2" color="red" >(*)</font></nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_e_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_e_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용유무<font size="2" color="red" >(*)</font></nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_usegb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="T^사용,F^미사용">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>적요</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>입력자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>입력일시</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>수정자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_upid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>수정일시</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_updt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td  class="tab12" align=center colspan=2  style= "height:130px" > <font size="2" color="red" >(*)</font> 표시건은 필수 항목입니다.</td>
					</tr>
			  </table>
		 </td>
		 </tr>
		</table>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp2 classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=EMPID        Ctrl=txt_empid         Param=value</C>
	<C>Col=EMPNO        Ctrl=gcem_empno        Param=text</C>
	<C>Col=EMPNMK	    Ctrl=gcem_empnmk       Param=text</C>
	<C>Col=S_DATE	    Ctrl=gcem_s_date       Param=text</C>
	<C>Col=E_DATE	    Ctrl=gcem_e_date       Param=text</C>
	<C>Col=USEGB	    Ctrl=gcra_usegb        Param=codevalue</C>
	<C>Col=REMARK	    Ctrl=txt_remark        Param=value</C>
	<C>Col=WRDT 	    Ctrl=txt_wrdt          Param=value</C>
	<C>Col=WRID 	    Ctrl=txt_wrid          Param=value</C>
	<C>Col=UPDT 	    Ctrl=txt_updt          Param=value</C>
	<C>Col=UPID 	    Ctrl=txt_upid          Param=value</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



