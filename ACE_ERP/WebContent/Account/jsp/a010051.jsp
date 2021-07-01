<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 업체등록승인  
+ 프로그램 ID	: a010051.jsp
+ 기 능 정 의	: 업체등록승인   
+ 최 초 이 력	: 
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  : 반송사유 추가 
+ 수   정  자  :  정영식
+ 수 정 일 자  : 2013.04.01
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010051_s1, a010051_t1
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
    
    gclx_status_0.bindcolval ="N";
    
    gcra_usegb_0.codevalue="1";
   // gcra_use_tag_0.codevalue ="Y";	
    //gcra_use_tag.codevalue ="Y";	  
    
   // txt_empno.value =gusrid;
	//txt_empnmk.value = gusrnm;
  
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="+gcem_vend_id_0.text    
                                                                        +"&v_str5="   	
                                                                        +"&v_str6="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                        
    //prompt('',gcds_data.DataID);
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
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
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
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t2";
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
			
			//해외거래처 -- 등록번호 없음. F 거래처 명으로 중복 체크 
			//직원          -- 등록번호 없음. K 거래처 번호로 중복 체크 
			//그 외 일반은 사업자등록번호 //주민번호로 중복 체크 
			if(gcds_data.namevalue(p,"VEND_CD").substring(0,1)=="F"){
				
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s66?v_str1="+gcds_data.namevalue(p,"VEND_CD").substring(0,1); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert("중복된 번호가 존재합니다1.\n\n확인하시고 다시 입력해 주십시오.");
					return false;
				}	
			}else if(gcds_data.namevalue(p,"VEND_CD").substring(0,1)=="K"){
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s66?v_str1="+gcds_data.namevalue(p,"VEND_CD").substring(0,1); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert("중복된 번호가 존재합니다2.\n\n확인하시고 다시 입력해 주십시오.");
					return false;
				}	
			}else {
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+gcds_data.namevalue(p,"VEND_ID"); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert(gcds_data.namevalue(p,"VEND_ID")+" 중복된 번호가 존재합니다.\n\n확인하시고 다시 입력해 주십시오.");
					return false;
				}	
			}	
		}
	}
	
	
  	 
	
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
		  
			gctr_pyo.KeyValue = "Account.a010051_t3(I:USER=gcds_data)";
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t3";
            gctr_pyo.Parameters="v_str1="+gusrid;

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
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
							+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
							+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
							+ "USE_TAG:STRING,"
							+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
							+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING"
							+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
}

function link_1(url){  // default 창
  var stat='top=0,left=50,width=1024,height=768,toolbar=1,location=1,status=1,menubar=1,scrollbars=1,directories=0,resizable=1';

  newWin=window.open('','',stat);
  newWin.location=url;
}

<%
//파일 다운
%>
function fnFileDown(intno){
	
	//alert("gcds_data.rowposition:::"+gcds_data.rowposition);
	var strReal_file="";
	var strSys_file="";
	
	
	if(gcds_data.rowposition<0){
		alert("해당 거래처를 선택하십시요.");
		return false;
	}
	
	
	if(intno==4){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4")==""){
			alert("사업자등록증의 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE4");
		}
	}else if(intno==3){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3")==""){
			alert("등기부등본의 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE3");
		}
		
	}else if(intno==2){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2")==""){
			alert("완납증명서의 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE2");
		}
	}else if(intno==1){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1")==""){
			alert("기타의 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE1");
		}
	}
	
	
	
	location.href ="./a010050_fileDownload.jsp?dir=&filename="+strReal_file+"&sysfilename="+strSys_file; //운영
	
	
	/*
	var real_fileList="";
	var fileHtml="";				
	var real_fileList =txt_real_file.value;
	var real_file10= new Array();		
	
	real_file10 = real_fileList.split(":");	//배열로 정리
	
	var real_file1=real_file10.slice(0,1);
	
	
	if(real_file1==""){
		alert("첨부파일이 존재하지 않습니다")
		return;
	}else if(real_file1.length==1){
		location.href ="./a500010_fileDownload.jsp?dir=&filename="+real_file1+"&sysfilename="+real_file1; //운영
		
	}
	*/
	
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
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
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
    <td ><img src="../img/a010051_head.gif"></td>
    <td width="688" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand" onclick="ln_Apply()" >
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sendbak.gif"	style="cursor:hand" onclick="ln_SendBack()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="100px;" bgcolor="#eeeeee" align="center">거래처코드</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
				<param name=Text				    value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
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
		<td class="tab27" width="100px;" bgcolor="#eeeeee" align="center">번호구분</td>
		<td width="220px" class="tab11" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:240px;height:20px" >
				<param name=Cols		value="3">
				<param name=Format	value="1^사업자번호,2^주민번호,3^없음">
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
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">&nbsp;</td>
		<td class="tab11" ><nobr> &nbsp;
			<a href="Javascript:link_1('https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml')"><font color="blue"><b>사업자과세유형 조회연결</b></font></a>
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
 						 <PARAM NAME="DataID"		  VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"    VALUE="0">
						 <PARAM NAME="Indwidth"		  VALUE="0">
						 <PARAM NAME="Fillarea"		  VALUE="true">
						 <PARAM NAME="ColSizing"	  VALUE="true">
						 <param name="sortview"       value=left>
						 <param name="Editable"       value='true'>
						 <param name=UsingOneClick    value="1">
					     <PARAM NAME="Format"		  VALUE="  
					        <FC>ID=CHK 	         Name='선택'             Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center  	EditStyle=CheckBox   </C>  
							<G> Name=거래처정보         HeadBgColor=#B9D4DC
							<FC>ID=VEND_CD,	     Name=코드,		        width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=거래처명,			width=160,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=사업자번호,		    width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort=true</FC>
							<C> ID=COCOMYN,	     Name=업체구분,	        width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true EditStyle=Combo, Data='N:일반업체,T:간이과세업체,M:면세업체', show = true </C>
							<C> ID=VD_DIRECT,	 Name=대표자,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_CND,	 Name=업태,	            width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_KND,	 Name=업종,	            width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							</G>
							<C> ID=REMARK,   	 Name=비고,	            width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=EMPNMK,	     Name=작성자,	            width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=STATUS		 Name=상태,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none, sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
							<C> ID=SB_REASON,    Name=반송사유,	        width=100,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE4,   Name=사업자등록증,        width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE3,   Name=등기부등본,         width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE2,   Name=완납증명서,         width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE1,   Name=기타,             width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
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
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>거래처</td>
		<td width="350px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:50px;height:20px;" readOnly >
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:180px;height:20px;" readOnly>&nbsp;&nbsp;
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly      value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center>반송사유</td>
		<td width="310px"  class="tab24" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_sb_reason" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:280px;height:20px;" maxlength="50" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='30px'>
          <td colspan=2 ><b><font size="2" color="blue">[첨부파일]</font></b></td>
    </tr>
    
    <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>사업자등록증</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file4' id="txt_real_file4" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('4')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>등기부등본</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file3' id="txt_real_file3" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('3')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>완납증명서</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file2' id="txt_real_file2" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('2')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>기타</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file1' id="txt_real_file1" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('1')" >
			</nobr> 
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
	<C>Col=REAL_FILE4     Ctrl=txt_real_file4  	Param=value</C>
	<C>Col=REAL_FILE3     Ctrl=txt_real_file3  	Param=value</C>
	<C>Col=REAL_FILE2     Ctrl=txt_real_file2  	Param=value</C>
	<C>Col=REAL_FILE1     Ctrl=txt_real_file1  	Param=value</C>
	
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



