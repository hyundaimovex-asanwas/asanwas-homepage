<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 분양연동   
+ 프로그램 ID: a040090.jsp
+ 기 능 정 의	: 거래처 일괄등록 
+ 최 초 이 력	: 2013.05.06 
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  :
+ 수   정  자  : 
+ 수 정 일 자  :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a040090_s1, a040090_t1
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
var gs_gubun=""; //chk 시 click구분



/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    
    gclx_ingb_0.bindcolval ="0";
    gclx_seqno_0.bindcolval="0";
    gclx_regsts_0.bindcolval="0";
   
    
    //txt_empno.value =gusrid;
	//txt_empnmk.value = gusrnm;
  
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040091_s1?v_str1="+gclx_ingb_0.bindcolval
	                                                                                                                              +"&v_str2="+gclx_seqno_0.bindcolval
	                                                                                                                              +"&v_str3="+gclx_regsts_0.bindcolval;
	                                                                                                                               	                                                                                                                                                                                                                                           
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
}




/******************************************************************************
	Description : 이괄 등록 저장
******************************************************************************/
function ln_Save(){


		
     gcds_data2.clearall();
     ln_SetDataHeader();

   //상태값 변경 
   for(var i =1; i<=gcds_data.countrow; i++){
   	 	if (gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"VEND_STS")=="N"){ //미등록건
   	 	    gcds_data2.addrow();
   	 	    gcds_data2.namevalue(gcds_data2.rowposition,"BS_ID")= gcds_data.namevalue(i,"BS_ID");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_VEND_ID")= gcds_data.namevalue(i,"C_VEND_ID");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_VEND_CD")= gcds_data.namevalue(i,"C_VEND_CD");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_SEQ")= gcds_data.namevalue(i,"C_SEQ");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_EMPNM")= gcds_data.namevalue(i,"C_EMPNM");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_DEPTNM")= gcds_data.namevalue(i,"C_DEPTNM");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_EMAIL")= gcds_data.namevalue(i,"C_EMAIL");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_HPNO")= gcds_data.namevalue(i,"C_HPNO");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_TELNO")= gcds_data.namevalue(i,"C_TELNO");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_ENDDT")= gcds_data.namevalue(i,"C_ENDDT");
			gcds_data2.namevalue(gcds_data2.rowposition,"C_USEGB")= gcds_data.namevalue(i,"C_USEGB");
   	 	}
   }





	if(!ln_Chk_Save())return;
	//else if (gcds_data.IsUpdated) {
	   // if(!ln_Chk_Save_Status())return;
	   
	   /**
	   //상태값 변경 
	   for(var i =1; i<=gcds_data.countrow; i++){
	   	 	if (gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"VEND_STS")=="N"){ //미등록건
	   	 	    gcds_data.UserStatus(i)="1";	//insert   	 	
	   	 	}
	   }
	   **/
	   
	    if(gcds_data2.isupdated){
			if (confirm("해당 거래처 담당자를 등록하시겠습니까?")){	
				gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040091_t1";
				gctr_pyo.Parameters = "v_str1="+gs_userid;
			
				//prompt(this, gcds_data2.text);
				gctr_pyo.post();
			}	
	   }
	    
}





/******************************************************************************
	Description : 입력값 체크
	//상태값이 대기일 경우만 생성 가능 
	//사업자번호 및 주민번호 체크해야할까????
******************************************************************************/
function ln_Chk_Save() {

  //상태값이 대기 일경우만 가능 

   for(i=1;i<=gcds_data2.countrow;i++){
   		if(gcds_data2.SysStatus(i)=="1"||gcds_data2.SysStatus(i)=="3"){
   			if(gcds_data2.namevalue(i,"C_VEND_ID") == ""){//사업자등록번호
				alert(i+" 행의 등록번호를 입력하세요.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"C_VEND_CD") == ""){//거래처코드
				alert(i+" 행의 거래처코드을 입력하세요.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"C_EMPNM") == ""){//담당자
				alert(i+" 행의 담당자명을 입력하세요.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"C_EMAIL") == ""){//이메일
				alert(i+" 행의 이메일을 입력하세요.");
				return false;
			}
			
		}
   }

   return true;
}




/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Save_Status(){
   /*
	for(var i =1; i<=gcds_data.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 수정 가능건이 아닙니다.");
				return false;
			}
		}
	}

	return true;
	*/
}

/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Status(){
/**
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 요청 가능건이 아닙니다.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
			
			vcnt+=1;
		}
	}
	
	if (vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	return true;
	**/
}





<%
/***********************************************************************************************
	Description : 데이터 복사 
	parameter   :
**********************************************************************************************/
%>
function fnDataCopy(intRow){

	if (intRow ==0){
		for (var i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
			    gcds_data.namevalue(i,"C_VEND_CD")=gcds_data.namevalue(i,"VEND_CD"); 	
				gcds_data.namevalue(i,"C_VEND_ID")=gcds_data.namevalue(i,"VEND_ID"); 	
				gcds_data.namevalue(i,"C_EMPNM")=gcds_data.namevalue(i,"BS_EMPNM"); 	
				gcds_data.namevalue(i,"C_EMAIL")=gcds_data.namevalue(i,"BS_EMAIL"); 	
				gcds_data.namevalue(i,"C_HPNO")=gcds_data.namevalue(i,"BS_HPNO"); 	
				gcds_data.namevalue(i,"C_TELNO")=gcds_data.namevalue(i,"BS_TELNO"); 	
				gcds_data.namevalue(i,"C_USEGB")="T";	
			}
		}
	}else{
		if(gcds_data.namevalue(intRow,"CHK")=="T"){
				gcds_data.namevalue(intRow,"C_VEND_CD")=gcds_data.namevalue(intRow,"VEND_CD"); 	
				gcds_data.namevalue(intRow,"C_VEND_ID")=gcds_data.namevalue(intRow,"VEND_ID"); 	
				gcds_data.namevalue(intRow,"C_EMPNM")=gcds_data.namevalue(intRow,"BS_EMPNM"); 	
				gcds_data.namevalue(intRow,"C_EMAIL")=gcds_data.namevalue(intRow,"BS_EMAIL"); 	
				gcds_data.namevalue(intRow,"C_HPNO")=gcds_data.namevalue(intRow,"BS_HPNO"); 	
				gcds_data.namevalue(intRow,"C_TELNO")=gcds_data.namevalue(intRow,"BS_TELNO"); 	
				gcds_data.namevalue(intRow,"C_USEGB")="T";	
		}
	}
}



<%
/******************************************************************************************
		Descrition : 사업자번호 중복 체크 
******************************************************************************************/
%>
function ln_Vendid_Chk(irow){

	for(var i = 1; i<=irow;i++){
		if (i>1){
			if(gcds_data.namevalue(i-1,"VEND_CD")==gcds_data.namevalue(i,"VEND_CD")){
				gcds_data.namevalue(i,"VEND_STS") = "Y";
			}
		}
	}
}


function ln_SetDataHeader(){

       var s_temp = "BS_ID:DECIMAL,C_VEND_ID:STRING,C_VEND_CD:STRING,C_SEQ:DECIMAL,C_EMPNM:STRING,"  
                         + "C_DEPTNM:STRING,C_EMAIL:STRING,C_HPNO:STRING,C_TELNO:STRING,C_ENDDT:STRING,"   
                         + "C_USEGB:STRING";    
       gcds_data2.SetDataHeader(s_temp);
}



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue"  VALUE="a040091_t1(I:USER=gcds_data2)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
     ln_Vendid_Chk(rowcount);
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
//		ln_Query();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>

	if((row==0) && (colid=="CHK")){
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;
	
        for(i=1;i<=gcds_data.countrow;i++){
            if(gs_gubun=="1"||gs_gubun==""){
	        	if(gcds_data.namevalue(i,"VEND_STS")=="N"){
		        	gcds_data.namevalue(i,"CHK")="T";	        
		        	fnDataCopy(i); 		
	        	}
            }else{
            	if(gcds_data.namevalue(i,"VEND_STS")=="N"){
		        	gcds_data.namevalue(i,"CHK")="F";	   
		        	gcds_data.undo(i);  
	        	}
            }	
		}

   }else if((row!=0) && (colid=="CHK")){
   	     if(gcds_data.namevalue(row,"VEND_STS")=="N"){
		    if(gcds_data.namevalue(row,"CHK")=="T"){
		 			fnDataCopy(row);
		 	}else{
		 	        gcds_data.undo(row);
		 	}
		 }else{
		 
		 	if(gcds_data.namevalue(row,"VEND_STS")!="Y"){
		 		gcds_data.undo(row);
		 	}
		 }
   }
   
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

</script>

<script language=JavaScript for=gcgd_pyo event=onKeyPress(keycode)>

    if(gcds_data.namevalue(gcds_data.rowposition,"VEND_STS")=="N"||gcds_data.namevalue(gcds_data.rowposition,"VEND_STS")=="Y"&&gcds_data.namevalue(gcds_data.rowposition,"VEND_UPT")=="U"){
	    if(gcds_data.namevalue(gcds_data.rowposition,"CHK")=="T"){
	 			fnDataCopy(gcds_data.rowposition);
	 	}else{
	 	        gcds_data.undo(gcds_data.rowposition);
	 	}
	 }else{
	 	gcds_data.undo(gcds_data.rowposition);
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

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040091_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">   
        	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		    style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="100px;" bgcolor="#eeeeee" align="center">입금구분</td>
			<td width="190px" class="tab18" align="left"><comment id="__NSID__">
			<object id=gclx_ingb_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^계약금,2^중도금1차 ,3^중도금2차 ,4^중도금3차 ,5^중도금4차 ,6^잔금">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">회수</td>
			<td width="190px" class="tab24" align="left" ><comment id="__NSID__">
				<object id=gclx_seqno_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^1회,2^2회,3^3회,4^4회,5^5회">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">등록구분</td>
			<td class="tab14"  align="left">
			<comment id="__NSID__">
			<object id=gclx_regsts_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-35px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^미등록,2^등록">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
			
		</tr>
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:866px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			 VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"   VALUE="0">
						 <PARAM NAME="Indwidth"		 VALUE="0">
						 <PARAM NAME="Fillarea"		     VALUE="true">
						 <PARAM NAME="ColSizing"		 VALUE="true">
						 <param name="Editable"     	 value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"			 VALUE="  
					        <C>ID=CHK 	                 Name='선택'               width=28   HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<G>  Name='분양정보',                                                     HeadBgColor=#B9D4DC,  align=center, 
							<C>ID=BS_INGB,	         Name=입금,	            width=80,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true   EditStyle=Combo	Data='1:계약금,2:중도금1차,3:중도금2차,4:중도금3차,5:중도금4차,6:잔금'</C>
							<C>ID=BS_SEQNO,	     Name=회수,	            width=40,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true   EditStyle=Combo	Data='1:1회,2:2회,3:3회,4:4회,5:5회'</C>
							<C>ID=BS_DNO,	         Name=동,		            width=35,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true  </C>
							<C>ID=BS_HNO,	         Name=호,		            width=35,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true </C>
							<C>ID=BS_EMPNM,	     Name=담당자,             width=50,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true </C>
							<C>ID=BS_EMAIL,	         Name=이메일,	           width=110,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=left,        edit=none, sort=true </C>
							</G>
							<G>  Name='거래처정보',                                  HeadBgColor=#B9D4DC,  align=center, 
							<C> ID=VEND_ID,	         Name=사업자번호,		width=90,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							<C> ID=VEND_NM,	     Name=사업체명,	        width=90,  HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=left,		edit=none  sort = true  </C>
							<C> ID=VD_DIRECT,	     Name=대표자, 	        width=50,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							<C> ID=VEND_CD,	     Name=거래처,	            width=50,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							</G>
							<G> Name='담당자정보' ,                                  HeadBgColor=#B9D4DC, align=center, 
							<C> ID=C_EMPNM,	     Name=담당자,     	    width=50,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							<C> ID=C_EMAIL,	         Name=이메일,	            width=110,HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=left,    	edit=none  sort = true  </C>
							<C> ID=C_VEND_ID,	     Name=사업자번호,		width=90,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							<C> ID=C_VEND_CD,	 Name=거래처,	            width=70,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>							
							</G>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
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

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		
	'>
</object></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



