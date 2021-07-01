<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 수정세금계산서 - 수정사유 선택
+ 프로그램 ID	:  a040077_popup2.jsp
+ 기 능 정 의	:  수정사유
+ 작   성   자     :  정 영 식
+ 서 블 릿 명	:  a040077_popup2_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>당초승인번호찾기</title>


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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	 
	//txt_atcode_fr.value= strParam.g_arrParam[0];
}
/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){

	
}

/******************************************************************************
Description : 창닫기
parameter   : A - 선택
******************************************************************************/
function ln_Close(){
	
	var returnval="";
	
	if(rdoType01.checked==true){
		returnval="01"; 
	}else if (rdoType011.checked==true){
		returnval="011";
    }else if (rdoType06.checked==true){
    	returnval="06";
	}else if (rdoType02.checked==true){
		returnval="02";
	}else if (rdoType04.checked==true){
		returnval="04";
	}else if (rdoType03.checked==true){
		returnval="03";
	}else if (rdoType05.checked==true){
		returnval="05";
	}else if (rdoType051.checked==true){
		returnval="051";
	}
	
	window.returnValue = returnval;   
	window.close();
}




/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<!-- 매입 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr>
		<td height="40px">
			<b><font size="3" color="blue">&nbsp;◎ 수정사유선택</font></b>
		</td>
		<td align = right> 	
			<img src="../../Common/img/btn/com_b_select.gif"  style="cursor:hand;"   onClick="ln_Close()"> 
		<td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px" colspan =2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<!-- 기재사항 착오 정정 01 -->
				<tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =3 >
						<nobr><b><font size="2" color="blue">기재사항 착오 정정 등</font></b></nobr></td>
					</td>
					<td class="tab22" style="width:470px;height:30px" colspan =2>
						<nobr><b>필요적 기재사항 등을 착오 또는 착오 외의 사유로 잘못 발급하는 경우, 세율을 잘못 적용하여 발급한 경우</b></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab21" style="height:30px" >
					   <nobr> <input type="Radio" name="rdoType" id="rdoType01" value="01" >
					          <b><font color="blue">당초 세금계산서</font></b></nobr></td>
						</nobr>
					</td>
					<td class="tab22" ><nobr>부(-)의 세금계산서 발행 (작성일자 : 당초 작성일)</nobr></td>
				</tr>
				<tr>
					<td class="tab21" >
						<nobr><input type="Radio" name="rdoType" id="rdoType011" value="011" >
					          <b><font color="blue">정정된 세금계산서</font></b>
					    </nobr>
					</td>
					<td class="tab22" ><nobr>정정된 내용의 (+)세금계산서 발행<BR> (작성일자 : 당초 작성일이 원칙이나 작성일자 잘 못 기재된 경우 올바른 작성일자 기재 )</nobr></td>
				</tr>
				
				<!-- 착오에 의한 이중발급 등 06-->
				<tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =2 >
						<nobr><b><font size="2" color="blue">착오에 의한 이중발급 등</font></b></nobr></td>
					</td>
					<td class="tab22" style="height:30px"  colspan=2>
					   <nobr><b>착오로 이중 발급한 경우, 면세 등 발급대상이 아닌 거래 등에 대하여 발급한 경우</b></nobr></td>
				</tr>
				<tr>
					<td class="tab21" style="height:30px" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType06" value="06" >
					   		 <b><font color="blue">착오에 의한 이중발급 등</font></b>
					   </nobr>
					</td>
					<td class="tab22" ><nobr>부(-)의 세금계산서를 발행합니다. (작성일자 : 당초 작성일)</nobr></td>
				</tr>
			
			
			    <!-- 공급가액 변동 02 -->
			    <tr>
					<td class="tab11" style="width:20px;height:30px" bgcolor="#eeeeee">
						<nobr><b><font size="2" color="blue">공급가액 변동</font></b></nobr></td>
					</td>
					<td class="tab21" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType02" value="02" >
					   		 <b><font color="blue">공급가액 변동</font></b>
					   </nobr>
					</td>
					<td class="tab22"   >
					   <nobr>증감되는 금액에 대한 정(+) 또는 부(-)의 세금계산서를 발행합니다.<br/>
                             (작성일자 : 변동사유 발생일) <br />
                       <b><font color="red">비고1란 : 당초 세금계산서 작성일자 기재</font></b> 
                       </nobr>
                    </td>
				</tr>
				
			    
			    <!-- 계약의 해제   04-->
			    <tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =4 >
						<nobr><b><font size="2" color="blue">계약의 해제</font></b></nobr></td>
					</td>
					<td class="tab21" style="height:30px" rowspan =4 >
					   <nobr><input type="Radio" name="rdoType" id="rdoType04" value="04"  >
					   		 <b><font color="blue">계약의 해제</font></b>
					   </nobr>
					</td>
					<td class="tab22" style="height:30px" >
					   <nobr><b>변경전(2012.06.30 이전)</b></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab22" ><nobr>부(-)의 세금계산서를 발행합니다.(작성일자 : 당초 작성일)<br/>
					<b><font color="red">비고1란 : 계약 해제일 기재</font></b>
					</nobr></td>
				</tr>
				<tr>
					<td class="tab22" style="height:30px"><nobr><b>변경후(2012.7.1 이후)</b></nobr></td>
				</tr>
				<tr>
					<td class="tab22" ><nobr>부(-)의 세금계산서를 발행합니다.(작성일자 : 계약 해제일)<br/>
					<b><font color="red">비고1란 : 당초 작성일 기재</font></b>
				</nobr></td>
				</tr>
			    
			    <!-- 환입 03 -->
			     <tr>
					<td class="tab11" style="width:20px;height:30px" bgcolor="#eeeeee">
						<nobr><b><font size="2" color="blue">환입<font></b></nobr></td>
					</td>
					<td class="tab21" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType03" value="03" >
					   		 <b><font color="blue">환입</font></b>
					   </nobr>
					</td>
					<td class="tab22"   >
					   <nobr>환입 금액분에 대하여 부(-)의 세금계산서를 발행합니다.<br/>
                             (작성일자 : 환입된 날) <br />
                       <b><font color="red">비고1란 : 당초 세금계산서 작성일자 기재</font></b> 
                       </nobr>
                    </td>
				</tr>
			    
			    
			    <!-- 내국신용장 사후 개설 05 -->
			    <tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =2 >
						<nobr><b><font size="2" color="blue">내국신용장 사후개설</font></b></nobr></td>
					</td>
					<td class="tab21" style="height:30px" >
					   <nobr> <input type="Radio" name="rdoType" id="rdoType05" value="05" >
					          <b><font color="blue">당초 세금계산서</font></b></nobr></td>
						</nobr>
					</td>
					<td class="tab22" ><nobr>개설된 금액만큼 부(-)의 세금계산서 발행 (작성일자 : 당초 작성일)</nobr></td>
				</tr>
				<tr>
					<td class="tab21" >
						<nobr><input type="Radio" name="rdoType" id="rdoType051" value="051" >
					          <b><font color="blue">영세율 세금계산서</font></b>
					    </nobr>
					</td>
					<td class="tab22" ><nobr>영세율(+)세금계산서 발행 (작성일자 : 당초 작성일 ) <BR>
					<b><font color="red">비고1란 : 내국신용개설일자 기재</font></b> 
					</nobr></td>
				</tr>				
			</table>
		</td>
	</tr>
    <tr>			
		<td>	
			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [HEAD]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_head>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm0				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid0				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect0			Param=text</C>
		<C>Col=VENDNO		  Ctrl=gcem_vendno0			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
