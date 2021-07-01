<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 거래처 담당자 등록 승인  
+ 프로그램 ID	: a010048.jsp
+ 기 능 정 의	: 거래처 담당자 등록 승인  
+ 최 초 이 력	: 2017.05.31
+ 작   성   자	: 정영식
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    gclx_status_0.bindcolval ="N"
    gcra_usegb_0.codevalue="1";
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
	
	/*
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_s1?v_str1="+gcem_vend_cd_0.text
			                                                            +"&v_str2="+gcem_vend_nm_0.text
			                                                            +"&v_str3="+gcem_vend_id_0.text
			                                                            +"&v_str4="+gcem_empnm.text
			                                                            +"&v_str5="+gcra_useyn.codevalue;     	
	

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="+gcem_vend_id_0.text    
                                                                        +"&v_str5="   	
                                                                        +"&v_str6="+gcra_usegb_0.codevalue;     	                                                                                                                                                                                                                                        
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
	
	*/
   
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_s1?v_str1="+gcem_vend_cd_0.text
																	    +"&v_str2="+gcem_vend_nm_0.text
																	    +"&v_str3="+gcem_vend_id_0.text
																	    +"&v_str4="
																	    +"&v_str5=T"
																		+"&v_str6="+gclx_status_0.bindcolval
																		+"&v_str7="+gcra_usegb_0.codevalue;
	
	gcds_data.Reset();
	
}

/******************************************************************************
	Description : 승인
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Status()){
		return;
	}else if (gcds_data.IsUpdated) {
		if (confirm("업체 등록을 승인 하시겠습니까?")){	
			
			gctr_pyo.KeyValue = "Account.a010047_t2(I:USER=gcds_data)";
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t2";
			gctr_pyo.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_pyo.post();
			ln_Query();
		}	
	}
}


/******************************************************************************
	Description : 반송
******************************************************************************/
function ln_SendBack(){
		
	if(!ln_Chk_SendBack_Status())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("업체 등록을 반송 하시겠습니까?")){	
			
		gctr_pyo.KeyValue = "Account.a010047_t2(I:USER=gcds_data)";	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t2";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				alert("승인 대상 건이 아닙니다.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="Y"; 
			}
			vcnt+=1;
		}
	}
	
	if(vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	
	
	 /*
	 //화면상에서 동일건 체크 
  	 for(var k =1; k<=gcds_data.countrow;k++){
  	 	for(var j=k+1;j<=gcds_data.countrow;j++){
  	 	    //alert("k::"+k+"::j::"+j+"::"+gcds_data.namevalue(k,"VEND_ID")+":::"+gcds_data.namevalue(j,"VEND_ID"));
   	 		if(gcds_data.namevalue(k,"CHK")=="T"&& gcds_data.namevalue(j,"CHK")=="T" && gcds_data.namevalue(k,"VEND_ID")==gcds_data.namevalue(j,"VEND_ID")){
   	 		    alert(gcds_data.namevalue(k,"VEND_ID")+"  동일한 사업자 번호가 존재 합니다 .");
   	 			return false;
   	 		}
   	    }
  	 }
  	 
  	 
  	 //DB 상세서 동일건 체크 
  	 for(var p =1; p<=gcds_data.countrow;p++){
		if(gcds_data.namevalue(p,"CHK")=="T"){
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+gcds_data.namevalue(p,"VEND_ID"); 
			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(1,"CNT")>0){
				alert(gcds_data.namevalue(p,"VEND_ID")+" 중복된 번호가 존재합니다.\n\n확인하시고 다시 입력해 주십시오.");
				return false;
			}
		}
	}
	
	*/
  	 
	
	return true;
}




/******************************************************************************
	Description : 입력값 체크
******************************************************************************/

function ln_Chk_SendBack_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				alert("반송 대상 건이 아닙니다.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="B"; 
			}
			vcnt+=1;
		}
	}
	
	if(vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	
	return true;
}


<%
/******************************************************************************
	Description : 저장 
******************************************************************************/
%>
function ln_Save(){
	//if(!ln_Chk()) return;
	
	if (gcds_data.IsUpdated ){
		if (confirm("저장하시겠습니까 ?")) {
		  
			gctr_pyo.KeyValue = "Account.a010048_t1(I:USER=gcds_data)";
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010048_t1";
            gctr_pyo.Parameters="v_str1="+gusrid;

            //prompt("",gcds_data.text);
			gctr_pyo.post();
		}
	}
}


<%
/******************************************************************************
	Description : 체크  
******************************************************************************/
%>
function ln_Chk(){

/*
   // 거래처 코드 가 없는지 체크 
      for (var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"VEND_CD")==""){
			alert( i + "행의 거래처 코드를 확인 하세요");
			return false;
		}
    }
    */
       
	return true;

}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_usegb_format(strusegb){
	if(strusegb=="1"){ //
		gcem_vend_id.Format = "000-00-00000";        //법인 
	}else if(strusegb=="2"){
		gcem_vend_id.Format = "000000-0000000";  //개인 
	}
}


/******************************************************************************
	Description : Dataset Head 설정 -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:String(1),SEQ:Decimal(2),VEND_CD:String(13),VEND_NM:String(62),VEND_ID:String(15),EMPNM:String(30),"
			+ "EMAIL:String(40),DEPTNM:String(30),HPNO:String(15),"
			+ "TELNO:String(15),ENDDT:String(8),USEGB:String(1),BSNS_CND:String(62),BSNS_KND:String(62),I_EMPNO:String(10),"
			+ "U_EMPNO:String(10),STATUS:String(1),VEND_ID_LEN:Decimal(2),SB_REASON:String(100)";
		gcds_data.SetDataHeader(THeader);						
	}
}

function link_1(url){  // default 창
  var stat='top=0,left=50,width=1024,height=768,toolbar=1,location=1,status=1,menubar=1,scrollbars=1,directories=0,resizable=1';

  newWin=window.open('','',stat);
  newWin.location=url;
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 
</comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
   	ft_cnt01.innerText="데이타 조회중입니다.";
    document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data" event="onloadCompleted(row,colid)" >//총 조회 건수
    var icnt=0;

   	if(gcds_data.countrow<=0){
		alert("조회된 데이타가 없습니다.");
		ft_cnt01.innerText = "조회건수 : " + gcds_data.RealCount(1,row) + " 건";
	}else {
	  	ft_cnt01.innerText = "조회건수 : " + gcds_data.RealCount(1,row) + " 건";
	}
 
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //법인 
		gcem_vend_id.Format = "000-00-00000";            //법인 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";     //주민 
		gcem_vend_id.Format = "000000-0000000";        //주민
	}
</script>

<script language="javascript" for="gcgd_pyo" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

        //요청것만 전체 선택 되게 함.
        if(gcds_data.namevalue(1,"STATUS")!="R"){
        	alert("승인요청 건만 전체 선택 가능합니다.");
        	return false;
        }
	
		if(gcds_data.namevalue(1,"CHK")=="T"){
		  	for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="F";
		 	}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="T";
		 	}
		}
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
  <tr> 
    <td align="right" colspan=2>&nbsp;<nobr>
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Apply()" >
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sendbak.gif"	style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_SendBack()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >검색조건</td>
			<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">거래처코드</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">거래처명</td>
			<td width="200px" class="tab24" align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
				<param name=Text			        value="">
				<param name=Alignment		    value=0>
				<param name=Border			    value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">상태</td>
			<td class="tab14" >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-23px;top:2px;font-size:12px;width:100px;">
						<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
						<param name=CBDataColumns	     value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			     value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
			
		</tr>
		<tr> 
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">번호구분</td>
		<td width="160px" class="tab11" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="1^사업자번호,2^주민번호">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">번호</td>
		<td width="90px" class="tab11"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
						<param name=Text		   value="">
						<param name=Alignment      value=0>
						<param name=Border         value=true>
						<param name=Numeric        value=false>
						<param name=Format         value="000-00-00000">
						<param name=PromptChar     value="">
						<param name=BackColor      value="#CCCCCC">
						<param name=InheritColor   value=false>
						<param name=readOnly       value=false>
					   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">담당자명</td>
		<td class="tab11" ><nobr> &nbsp;
			<a href="Javascript:link_1('https://www.hometax.go.kr/websquare/websquare.wq?w2xPath=/ui/pp/index.xml&tmIdx=0&tm2lIdx=&tm3lIdx=')"><font color="blue"><b>사업자과세유형 조회연결</b></font></a>
		</td> 	 
		</tr> 
	</table>
	</td>
	</tr>

	<tr>
	<td colspan=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:876px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:876px;HEIGHT:322px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="sortview"         value=left>
						 <param name="Editable"     	value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='선택'             Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD,	     Name=거래처코드,		    width=85,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=거래처명,			width=160,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=사업자번호,		    width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort=true mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</FC>
							<C> ID=SEQ,	         Name=순번,	            width=40,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	edit=none  sort = true show = true </C>
							<C> ID=EMPNM,	     Name=담당자,	            width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=EMAIL,	     Name=담당자이메일,        width=150,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=COCOMYN,	     Name=업체구분,	        width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true EditStyle=Combo, Data='N:일반업체,T:간이과세업체,M:면세업체', show = true </C>
							<C> ID=VD_DIRECT,	 Name=대표자,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_CND,	 Name=업태,	            width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_KND,	 Name=업종,	            width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=EMPNMK,	     Name=작성자,	            width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true  show=false</C>
							<C> ID=STATUS		 Name=상태,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none, sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
							<C> ID=SB_REASON,    Name=반송사유,	        width=100,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
					 <fieldset style="position:relative;left:0px;width:878px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
				</td>
			  </tr>
			 </table>
			</td>
		 </tr>
		</table>
  </td>	
  </tr>		
  </table>

  <table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td  ><b><font size="2" color="blue">[반송사유 등록]</font></b></td>
          <td align=right  >
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
		  </td>
    </tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"   class="tab25"  bgcolor="#eeeeee" align=center>거래처</td>
		<td width="380px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:65px;height:20px;" readOnly >
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:180px;height:20px;" readOnly>&nbsp;&nbsp;
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
				<param name=Text             value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	    value="_">
				<param name=BackColor       value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly        value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center>반송사유</td>
		<td width="280px"  class="tab24" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_sb_reason" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:250px;height:20px;" maxlength="50" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>
    
 <comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_data">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value</C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value</C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text</C>
	<C>Col=SB_REASON      Ctrl=txt_sb_reason  	Param=value</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



