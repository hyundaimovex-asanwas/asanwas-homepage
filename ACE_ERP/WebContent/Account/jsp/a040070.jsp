<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	회계관리/역발행매입요청(전자세금계산서)
+ 프로그램 ID	: A040070.html
+ 기 능 정 의	: 역발행매입요청(전자세금계산서)
+ 최 초 이 력	: 정영식
+ 변 경 이 력	:  
+           : 공급받는자인 현대아산이 매입세금계산서를 요청한다.
+               ( ATTAXMST 와 ATTAXDTL 의 데이터를 가지고  
+                 XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS에 데이터를 넣는다.
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a040070_s1 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>역발행 매입요청</title>
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
//document.domain = "http://erp.hdasan.com"; 
var gs_gubun="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

  //&&
	//newWin=window.open('inform.html','child','width=350,height=230,top=310,left=350');


	gclx_cocode.index=2;
	//ln_Find_Regno();
	//ln_Query(gcem_regno.text);
    ln_Before();

    //gcem_frdt.text="20090801";
	//gcem_todt.text="20090831";

	gclx_fdcode.index=1;

	gcem_frdt.text=ln_Load_Date('s');
    gcem_todt.text=ln_Load_Date('c');
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	ln_Authority();
}

/******************************************************************************
	Description : 권한조회
******************************************************************************/
function ln_Authority(){
	
	//login자와 부가세 관리자확인---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
	}else{
		hid_login.value="";	
	}
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
		
  var strcocode ="";																

  if(gclx_cocode.bindcolval=="00"){
	  strcocode ="";
  }else{
	  strcocode =gclx_cocode.bindcolval;
  }			

  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040070_s1?v_str1="+gclx_fdcode.bindcolval   //지점                
	                                                                    +"&v_str2="+strcocode	 //사업소              
																		+"&v_str3="+gcem_frdt.text					 //계산서기간 from     
																		+"&v_str4="+gcem_todt.text					 //계산서기간 to       
																		+"&v_str5="+gcem_regno.text					 //사업자등록번호      
																		+"&v_str6="+gcem_vendnm.text				 //거래처명            
																		+"&v_str7="+gcem_vendcd.text				 //거래처코드    
																		+"&v_str8="+gusrid	                 //id          
																		+"&v_str9="+hid_login.value;	       //관리자구분		
	//prompt("",gcds_data.DataID);
  gcds_data.Reset();

}

/******************************************************************************
	Description : 역발행 매입요청
	데이터를 XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS에 INSERT 해야함.
******************************************************************************/
function ln_Save(){
  var strregno ="2218113834";

	
  if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
  else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;

  if (gcds_data.IsUpdated) {
	  if(!ln_Chk())return;
	  if (confirm("역발행 매입요청 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040070_t1"

			gctr_data.Parameters = "v_str1="+strregno+",v_str2="+gusrid;
			//prompt('',gcds_data.text);
			gctr_data.post();
	  }	
   }

 /*
  if(!ln_Chk()) return;
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;            

	
	if(gcds_data.namevalue(1,"CHK")=="T"){        //서울인 경우
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(2,"CHK")=="T"){  //고성인 경우
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

  window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
	*/
}

/******************************************************************************
	Description : 사업소 코드로 사업자등록번호 찾기 
******************************************************************************/
function ln_Find_Regno(){
  /*
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    gcem_regno.text =gs_regno_s;
	}else{
    gcem_regno.text ="";
	}
	*/
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Chk(){

    //2009.08.14 인사기본정보에 Email 이 없는 경우 오류 발생
	gcds_email_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040070_s2?v_str1="+gusrid;  //사번                               
	//prompt("",gcds_email_chk.DataID);
    gcds_email_chk.Reset();

	//alert(gcds_email_chk.namevalue(gcds_email_chk.rowposition,"EMAIL"));

	if(gcds_email_chk.namevalue(gcds_email_chk.rowposition,"EMAIL")==""||gcds_email_chk.namevalue(gcds_email_chk.rowposition,"EMAIL")==undefined){
	  alert("사번 "+gusrid+" 의 인사기본정보 Email을 확인하십시요.");
	  return false;
    }else{
      return true;
	}

  /*
	var intcnt = 0; 

  //인증서 선택이 한 것도 안 된경우
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
  if (intcnt==0){
		alert("해당 사업자 번호를 선택하십시요.");
		return false;
	}else if(intcnt==1){
    return true;
	}else if(intcnt==2){
		alert("사업자 번호를 1건만 선택하십시요.");
		return false;
	}else{
    alert("기타");
    return false;
	}
	*/
}
/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){
    	var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
			gcem_regno.text	= arrParam[5];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
			gcem_regno.text="";
		}
}


/******************************************************************************
	Description : 스마트 모듈 호출 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){

    var v_left = (screen.width-300)/2;
    var v_top  = (screen.height-300)/2;
   	url=gs_url+"/callSB_V3/XXSB_DTI_ISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
	window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_email_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 권한관리 -->
<object id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a040060_t1(I:USER=gcds_data,O:USER2=gcds_return)">
  </object>
 </comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
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
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
  
	//ln_Find_Regno();
  //ln_Query(gcem_regno.text);

</script>

<script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
  
	if(row==0 && colid=="CHK"){ //전체선택              
		if(gcds_data.namevalue(1,"CHK")=="T"){ //첫행이 체크 되어 있을 경우
			for(i=1;i<=gcds_data.Countrow;i++){
				gcds_data.namevalue(i,"CHK") = "F";
			}//for
		}else{
			for(i=1;i<=gcds_data.Countrow;i++){  //첫행이  체크 되지 않을 경우 모두 체크 
				gcds_data.namevalue(i,"CHK") = "T";
			}//for
		}
	}else if (row!=0 && colid=="CHK"){  //개별선택
      
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		if(gs_gubun=="1"||gs_gubun==""){
			gcds_data.namevalue(row,"CHK")="T";
		}else{
			gcds_data.namevalue(row,"CHK")="F";
		}
	}


</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>
 
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040070_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
      	<img src="../../Common/img/btn/com_b_op_order.gif"  style="cursor:hand" onclick="ln_Save()">
		<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onclick="ln_Query()"></nobr>
	</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;" >
		<tr> 
      		<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>지점코드</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;width:100px;">
					<param name=ComboDataID			value="gcds_fdcode">
					<param name=CBDataColumns		value="FDCODE,FDNAME">
					<param name=SearchColumn		value="FDNAME">
					<param name=Sort				value=false>
					<param name=Enable              value="true">
					<param name=ListExprFormat	    value="FDNAME^0^100">
					<param name=BindColumn			value="FDCODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>사업소</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:100px;">
					<param name=CBData			value="00^전체,01^고성,02^서울,04^홍성">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			value=false>
					<param name=ListExprFormat	Value="CODE^1^30,NAME^1^60">								
					<param name=BindColumn		value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>발행기간</nobr></td>
			<td width="400px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
				<comment id="__NSID__">
				<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
			</td>
		</tr>
		<tr> 
      <td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>사업자등록번호</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:80px;height:20px;">
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="000-00-00000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<!-- <param name=ReadOnly      value=true> -->
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>거래처명</nobr></td>
			<td width="150px" class="tab19" colspan=3><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:250px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit value="true">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
			  <comment id="__NSID__">
				<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#############">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';gcem_regno.text=''">
			  </nobr> 
			</td>
		</tr>
		</table>
   </td>
	</tr>

	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		  VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='선택'	           ID=CHK         	     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	EditStyle=CheckBox </FC> 
						<FC> Name='전표번호'		   ID=SLIPNO        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=105	align=cneter	edit=none  Mask='XXXXXXXXX-XXXXXX'</FC>
						<FC> Name='거래처명'		   ID=VEND_NM       	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none</FC>
						<FC> Name='사업자등록번호'	   ID=VEND_ID   	     HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center    edit=none  Mask='XXX-XX-XXXXX'</FC>
						<C>  Name='공급가액'		   ID=TAXSUM        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		edit=none</C>
						<C>  Name='부가세액'		   ID=TAXVATAMT          HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=right		edit=none</C>
						<C>  Name='합계'            ID=TAXTOT   			 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  	edit=none</C>
						<C>  Name='적요'            ID=REMARK        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left  	edit=none</C>
						<C>  Name='상태'            ID=DTI_STATUS     	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left  	edit=none  EditStyle=Combo Data='A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
						<C>  Name='계산서번호'       ID=TAXNBR        	     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left  	edit=none  Mask='XXXXXXX-XXXX'</C>
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td> </tr>	
	<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
</table>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
