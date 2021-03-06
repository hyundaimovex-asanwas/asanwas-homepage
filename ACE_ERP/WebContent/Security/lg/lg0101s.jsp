<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 정보보보>정보관리>기록관리>개인정보처리
* 프로그램 ID	: lg0101S.jsp
* 기 능 정 의	: 개인정보처리
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2016.6.8
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>개인정보처리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//트리초기화 호출
	
    fnInit();
    
	gcem_staxdatfr.text = gcurdate;
	
	gcem_staxdatto.text = gcurdate;
	
	fnSelect();
    
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
		

    
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
														+ ",v_staxdatfr=" + gcem_staxdatfr.text					//시작일자
														+ ",v_staxdatto=" + gcem_staxdatto.text					//시작일자														
														+ ",v_access_gb=" + cmbACCESS_GB.value				//해당시스템														
														+ ",v_act_gbn=" + cmbACT_GBN.value						//수행업무
	 													;
	 
	 //alert(param);
	 
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lg0101S",  "JSP(O:DS_DEFAULT=ds_default)",  param);

    tr_post(tr1);

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   		Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>



 </script>

<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
	
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>기간</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					
					&nbsp;~
					
					<comment id="__NSID__">
					<object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	
		<td width="150px"   class="tab24" bgcolor="#eeeeee" align=center>해당시스템</td>
		<td width="200px" class="tab24"  >&nbsp;
                     <select id=cmbACCESS_GB style="WIDTH:100" >             
                        <option value="">전체</option>                
                        <option value="HR">인사</option>
                        <option value="ZACE">건설</option>
                        <option value="SALES">관광</option>                  
                    </select>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>수행업무</td>  
	    <td width="120px" class="tab24">&nbsp;
                     <select id=cmbACT_GBN style="WIDTH:100" >
                        <option value="">전체</option>                
                        <option value="S">조회</option>
                        <option value="I">입력</option>
                        <option value="U">수정</option>
                        <option value="D">삭제</option>
                        <option value="P">인쇄</option>                        
                    </select>
		</td>

	</tr>
</table>

<BR>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:500px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="30">
					<param name="Format"	 	 		value=" 
					<FC> Name='No'		  			ID={currow} 	  			HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=center	</FC>
                    <FC> Name='구분'  	          	ID=ACCESS_GB	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center   sort=true value={decode(ACCESS_GB, 'HR','인사','ZACE','건설','SALES','관광')}</FC>
					<FC> Name='프로그램ID'      ID=PROG_NM	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 	align=center   sort=true</FC>                    
					<FC> Name='수행 업무'         ID=ACT_GBN	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center   sort=true value={decode(ACT_GBN, 'S','조회','I','입력','U','수정','D','삭제','P','인쇄')}</FC>                    
					<FG> Name='접속자'  HeadBgColor=#B9D4DC
					<FC> Name='소속부서'  	    ID=DPT_NM          		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=center   sort=true </FC>
					<FC> Name='직위'  	        	ID=JOB_NM          		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center   sort=true </FC>					
					<FC> Name='성명'  	        	ID=ACCESS_NM          	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center   sort=true </FC>
					</FG>
					<C> Name='접속일시'  	      	ID=ACCESS_TIME         HeadAlign=Center HeadBgColor=#B9D4DC Width=200 	align=center    sort=true </C>
					<C> Name='IP'	      				ID=IPADDRESS 	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center    sort=true </C>

					">
			</object></comment><script>__ws__(__NSID__);</script>
			
			<fieldset style="position:relative;left:0px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
			
		</td>
	</tr>
</table> 
</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



