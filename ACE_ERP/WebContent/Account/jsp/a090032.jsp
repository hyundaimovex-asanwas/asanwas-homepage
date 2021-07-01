<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산총괄표
+ 프로그램 ID	: A090032.html
+ 기 능 정 의	: 자산대장 조회 화면
+ 작  성   자 : 정 영 식
+ 작 성 일 자 : 2011.08.01
-----------------------------------------------------------------------------
+ 수 정 내 용 : 자산총괄내용 저장 ( 감가상각 마감 후 적용 )  
+ 수   정   자 : 정영식
+ 수 정 일 자 : 2011.10.12
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090032_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산총괄표</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode = gfdcode;
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//소속코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

    if (fn_trim(gcem_yymm.text)==""){ 
 
	    if(gcem_toyymm.text==""){
			alert("조회년월을 확인하십시요");
			return;
		}
	
		if(gcem_byyyy.text==""){
			alert("전기년도를 확인하십시요");
			return;
		}
	
		if(gcem_cyyyy.text==""){
			alert("당기년도를 확인하십시요");
			return;
		}
	  	
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s2"
										  + "?v_str1="+gclx_fdcode.BindColVal              //지점
											+ "&v_str2="+gcem_toyymm.text                    //조회년월
											+ "&v_str3="+gcem_cyyyy.text                     //당기년도									
											+ "&v_str4="+gcem_byyyy.text;                    //전기년도 
	  //prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else{
	    alert(gcem_yymm.text.substring(0,4)+"년 "+gcem_yymm.text.substring(4,6)+"월의  저장된 자산총괄표를  조회합니다.");
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s4"
										  + "?v_str1="+gclx_fdcode.BindColVal         //지점
										  + "&v_str2="+gcem_yymm.text                    //기준년월								
	    //prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}
}

/******************************************************************************
	Description : 감가상각 조회
******************************************************************************/
function ln_Query2(){
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s3"
									  + "?v_str1="+gclx_fdcode.BindColVal              //지점          
										+ "&v_str2="+gcem_toyymm.text   								 //조회년월      
										+ "&v_str3="+gcem_cyyyy.text                     //당기년도										
										+ "&v_str4="+gcem_byyyy.text;                    //전기년도      
  //prompt('', gcds_code02.DataID);				
	gcds_code02.Reset();

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("자산총괄표","",2);
}


/******************************************************************************
	Description : 당월 감가 상각 마감건에 한하여 자산총괄표 저장 
******************************************************************************/
function ln_Save(){
	
	if(ln_Trim(gcem_toyymm.text)==""){
     	alert("년월을 입력하셔야합니다.");
     	return;
     }
     
    //alert("::"+gcem_toyymm.text+"::");
     

	//감가상각 마감 체크 
	
	
	ln_SetDataHeader();  //데이터셋 생성 
	
	ln_DataCopy();          //데이터 복사 
	
	
	//저장 ( 저장 시점에 기존재 체크하여 존재하면 저장안함. - 저장할 때 년월 입력해야함 . )  
	
	 if (confirm("저장하시겠습니까 ?")) {
		
		gctr_code01.KeyValue = "Account.a090032_t1(I:USER=gcds_astmmacht)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_t1";
	    gctr_code01.Parameters="v_str1="+gcem_toyymm.text+",v_str2="+gs_userid;		
	    //prompt('gcds_astmmccht',gcds_astmmccht.text);
		gctr_code01.post();
	}

}
/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_astmmacht.countrow<1){			
		var s_temp = "FDCODE:STRING(2),AST2ND:STRING(2),AST2NDNM:STRING(60),ASTYUSE:DECIMAL(5.2),BEFAQAMT:DECIMAL(13.0),"
                          + "CURAQAMT:DECIMAL(13.0),CLSAQAMT:DECIMAL(13.0),MOVAQAMT:DECIMAL(13.0),AQAMTSUM:DECIMAL(13.0),ABDEPRAMT:DECIMAL(13.0),"
                          + "ACDEPRAMT:DECIMAL(13.0),ACDEPRSUM:DECIMAL(13.0),REDUAMT:DECIMAL(13.0),DEAMTSUM:DECIMAL(13.0),JAAMTSUM:DECIMAL(13.0)";
		gcds_astmmacht.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : 데이터 복사 
******************************************************************************/
function ln_DataCopy(){
	gcds_astmmacht.ImportData(gcds_code01.ExportData(1,gcds_code01.CountRow,false));
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!-- 월별자산별 총괄 -->
<object  id=gcds_astmmacht  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<param name="KeyName"			value="toinb_dataid4">
	</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

//	gcgd_disp01.Editable =true;

	if(gcds_code01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else{
		if (gcem_yymm.text==""){ 
			ln_Query2(); 
		}
	}
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">

	for(var i=1;i<=gcds_code01.countrow;i++){
		for(var j=1; j<=row;j++){
			if(gcds_code01.namevalue(i,"AST2ND")==gcds_code02.namevalue(j,"AST2ND")){
				gcds_code01.namevalue(i,"ABDEPRAMT")=gcds_code02.namevalue(j,"ABDEPRAMT");
				gcds_code01.namevalue(i,"ACDEPRAMT")=gcds_code02.namevalue(j,"ACDEPRAMT");
				gcds_code01.namevalue(i,"ACDEPRSUM")=gcds_code02.namevalue(j,"ACDEPRSUM");
				gcds_code01.namevalue(i,"REDUAMT")=gcds_code02.namevalue(j,"REDUAMT");
			}
		}
	}

</script>


<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcem_toyymm event=onKillFocus()>
	
	if(gcem_toyymm.text!=""){
		gcem_cyyyy.text = gcem_toyymm.text.substring(0,4);
    	gcem_byyyy.text = gcem_cyyyy.text - 1 ;
	}
</script>


<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090032_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand;" onclick="ln_Save()"> 
		    <img src="../../Common/img/btn/com_b_excel.gif"	    style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	    value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="70px"  class="tab24"  bgcolor="#eeeeee" align=center>조회년월</td>  
	    <td width="100px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gcem_toyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
			<param name=Text					value="">
			<param name=Alignment     value=0>
			<param name=Border        value=true>
			<param name=Format        value="YYYY/MM">
			<param name=PromptChar    value="_">
			<param name=BackColor     value="#CCCCCC">
			<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_toyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>전기</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<OBJECT id=gcem_byyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:35px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="YYYY">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>당기</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<OBJECT id=gcem_cyyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:35px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="YYYY">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>기준년월</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<object  id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text					value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_yymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   value="20">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<FC> Name='중분류'  			  ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	   SumBgColor=#C3D0DB sumtext=''       </FC>
					<FC> Name='내용\\연수'	  ID=ASTYUSE		    HeadAlign=Center HeadBgColor=#B9D4DC Width=35 	align=right    SumBgColor=#C3D0DB sumtext='계'     </FC>
					<G> Name='취득금액'         HeadAlign=Center HeadBgColor=#B9D4DC
						<C> Name='전기취득'		  ID=BEFAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='당기신규취득'	  ID=CURAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='당기매각폐기'	  ID=CLSAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90    align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='당기이체대체'	  ID=MOVAQAMT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='계'	                  ID=AQAMTSUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90    align=right	 SumBgColor=#C3D0DB sumtext={sum(BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)}   Value={BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT} </C>
					</G>
					<G> Name='감가상각누계액'   HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='계'			          ID=DEAMTSUM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right	 SumBgColor=#C3D0DB sumtext={sum(ABDEPRAMT+REDUAMT+ACDEPRAMT)}  Value={ABDEPRAMT+REDUAMT+ACDEPRAMT} </C>
						<C> Name='전기누계'	  	  ID=ABDEPRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='손상차손누계'	  ID=REDUAMT  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
                        <C> Name='당기상각비'	  ID=ACDEPRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
					</G> 
                   <C> Name='잔존가액'	          ID=JAAMTSUM  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  SumBgColor=#C3D0DB sumtext={sum((BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)-(ABDEPRAMT+REDUAMT+ACDEPRAMT))}   Value={(BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)-(ABDEPRAMT+REDUAMT+ACDEPRAMT)} </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
			<br> * 기준년월은 기 저장된 자산총괄표를 조회함.
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 