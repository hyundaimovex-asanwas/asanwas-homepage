<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 		: ȯ�� ��  Help 
 * ���α׷�ID 	: ac430h
 * J  S  P		    : ac430h
 * �� �� ��		: Au430h
 * �� �� ��		: ������
 * �� �� ��		: 2008-03-20
 * �������		: ȯ�һ���ȸ 
 * [���� �� ��][������] ����
 * [2008-10-15][�ɵ���] �Աݾ� 1,7,8, ȸ�豸�� �ڵ� ����..
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	// �븮�� ����
	String gubun = HDUtil.nullCheckStr(request.getParameter("gubun"));
	String title = "ȯ�һ�����[ȯ�Ҿ�/ȯ�Ծ� �Է�/����]";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>ȯ�һ����� : ȯ�Ҿװ� ȯ�Ծ� �Է�, ���� ���ɡ���������������������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			var strParam=window.dialogArguments;
			var sRsv_sid = strParam.ds1.namevalue(strParam.ds1.rowposition,"rsv_sid");
			var sstatus_cd = strParam.ds1.namevalue(strParam.ds1.rowposition,"status_cd");
			
			//alert("sstatus_cd::"+sstatus_cd);
			
			function fnOnLoad() {
			    cfStyleGrid(getObjectFirst("gr1"), "comn");
			    fnSelect();
			
			   if(sstatus_cd=="JO"||sstatus_cd=="PO"){ //�����Ϸ�, ȯ�ҿϷ�
			   //if(sstatus_cd=="TO"){
			    	getObjectFirst("app").style.display = "inline";
		    		getObjectFirst("can").style.display = "inline";
				}else{
			        getObjectFirst("app").style.display = "none";
		    		getObjectFirst("can").style.display = "none";
				}
			    
			    
			    //if(sstatus_cd=="JO"){
			       	//getObjectFirst("app").style.display = "inline";
		    		//getObjectFirst("cal").style.display = "inline";
			    //}else{
			    	//getObjectFirst("app").style.display = "none";
		    		//getObjectFirst("cal").style.display = "none";
			   // }
			}
			
			/*
			function fnSelect() {
				fnSubSelect1();
			}
			*/
			//  
			function fnSelect() {
			   /*
				if(!keyword.value) {
					alert("�븮���ڵ� �Ǵ� �븮������ �Է����ּ���.");
					keyword.focus();
					return false;
				};
			   */	
			   
			    v_job="S";
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac430H?proType=S&dsType=1&sRsv_sid=" + sRsv_sid ;
				//prompt('ds1.Dataid::',ds1.Dataid  );
				ds1.Reset();
			
			}
			
			
			/*
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
									 ds1.namevalue(row, "client_nm") + ";" +
								 	 ds1.namevalue(row, "client_cd");
			 	fnClose();
			}
			
			*/
			function fnClose() {
				window.close();
			}
			
			
			function fnApply(){
			   /*
			    for(i=1;i<ds1.countrow;i++){
			    	alert("i::::"+i+"::::::::::"+ds1.SysStatus(ds1.RowPosition));
			   }
			   */
			   
			  if(sstatus_cd!="JO"&&sstatus_cd!="PO"){ //�����Ϸ�,ȯ�ҿϷ�
			  //if(sstatus_cd!="TO"){
			   		alert("�۾����°� �����Ϸ� �Ǵ� ȯ�ҿϷᰡ �ƴմϴ�. Ȯ�� �Ͻʽÿ�.");
			   		return;
			   }
			   			   
			   if(!fnApply_Chk()) return ; 
			   			
			   if (ds1.isUpdated ){ 
			        v_job = "I";	
			         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
			
			         ln_TRSetting(tr1, 
			             "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac430H",
			             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
			             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
			             
			             //prompt('',ds1.text);
			             tr_post(tr1);
		       }
			}
			
			
			//����� �ݾ� üũ 
			function fnApply_Chk(){
				for (i =1; i<=ds1.countrow;i++){
					if(ds1.namevalue(i,"PAY_AMT3")!=0  || ds1.namevalue(i,"PAY_AMT4")!=0){
						if(ds1.namevalue(i,"PAY_AMT1")<ds1.namevalue(i,"PAY_AMT3")+ds1.namevalue(i,"PAY_AMT4")){
							alert("�Աݾ׺��� ȯ��+ȯ�Ծ��� �� �����ϴ�. Ȯ�� �ٶ��ϴ�.");
							return false;
						}
					}
				}
				return true;
			}
			
			
            function fnCancel(){
				ds1.undoAll();
			}
            			
           // ������ ����Ÿ �� �������, ī��, ������, ������,�� ȯ�ұݾ��� Parent�� �ݿ���. 			
            function fnData_Trans(){
            
                var dblbank_amt=0;
                var dblcard_amt=0;
                var dblaccount_amt=0;
                var dbldepo_amt=0;
                var dblonline_amt=0;
                var dblgift_amt=0;
      	
            	for(k=1;k<=ds1.countrow;k++){
            		if(ds1.namevalue(k,"PAY_CD")=="020"){ //�������
            			dblbank_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="040"){ //�ſ�ī��, 
            		    dblcard_amt += ds1.namevalue(k,"PAY_AMT3"); 
            		}else if(ds1.namevalue(k,"PAY_CD")=="080"){ //������
            			dblaccount_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="100"){ //�����ݴ�ü 
            			dbldepo_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="050"){ //���ͳ� (ī��) 
            			dblonline_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="060"){ //��ǰ�� 
            			dblgift_amt += ds1.namevalue(k,"PAY_AMT3");
            		}
            	}

            	strParam.bank_amt.text = dblbank_amt;
            	strParam.card_amt.text = dblcard_amt;
            	strParam.account_amt.text = dblaccount_amt;
            	strParam.depo_amt.text = dbldepo_amt;
            	strParam.online_amt.text = dblonline_amt;
            	strParam.gift_amt.text = dblgift_amt;
            	
            	strParam.fnTotSum(); //�� �ڵ� ��� 
            }			
		
		</script>
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
	   //alert("���强��");
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
       	
        //�޽��� ó��
        var msg='';
        
        //alert("msgDS::"+msgDS.CountRow);
        
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);     
          	
         fnData_Trans(); 	    	
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
        
        //�����޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);		              
	</script>		
		
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		    /*
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
								 ds1.namevalue(row, "client_nm") + ";" +
								 ds1.namevalue(row, "client_cd");
			window.close();
			*/
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	;
            }
		</script>
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object  id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
</object>


<%=HDConstant.COMMENT_END%>

	</head>	
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:270px;">
						<tr>
							<td  height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:240;height:15;left:5px;"><%=title%></font>
								<input type="hidden" name="gubun" value="<%=gubun%>" style="width:20;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:200px">
						<tr>
							<td align=right>
							    <img src="<%=dirPath%>/Sales/images/save.gif"	 id=app style="cursor:pointer;position:relative;left:3px;top:3px;display:none"  onClick="fnApply()">
								<img src="<%=dirPath%>/Sales/images/cancel.gif" id=can style="cursor:pointer;position:relative;left:3px;top:3px;display:none"  onclick="fnCancel()">
								<img src="<%=dirPath%>/Sales/images/p_exit.gif"    style="cursor:pointer;position:relative;left:3px;top:3px;" onClick="fnClose()">  
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%>  style="width=489px; height:200px;border:1 solid #777777;">
						<param name="DataID"		  value="ds1">
						<param name="BorderStyle"   VALUE="0">
                		<param name=ColSizing         value="true">
                		<param name="editable"         value="true">
                		<param name=UsingOneClick  	value="1">
                        <Param Name="AllShowEdit"   value="True">
                        <param name=ViewSummary value=1>
						<param name="Format" 		  value="
							<c> Name='�Ա�����'	ID='PAY_DATE'		     Width=66  align=center   edit = none  SumText='�հ�'    mask='XXXX/XX/XX'  suppress=1 </c>
							<c> Name='�Աݱ���' 	ID='PAYNM'	  	         Width=62  align=center   edit = none  </c>
							<c> Name='�ǸŰ� ' 		ID='PAY_AMT0'	  	 Width=60  align=right      edit = none  SumText=@max  dec=0    </c>
							<c> Name='�Աݾ�' 		ID='PAY_AMT1'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
							<c> Name='��������' 	ID='PAY_AMT2'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
							<c> Name='ȯ�Ҿ�' 		ID='PAY_AMT3'	  	 Width=60  align=right      edit = RealNumeric  SumText=@sum  dec=0</c>
							<c> Name='ȯ�Ծ�' 		ID='PAY_AMT4'	  	 Width=60  align=right      edit = RealNumeric  SumText=@sum  dec=0</c>
							<c> Name='�������' 	ID='PAY_AMT5'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
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
				<!--  ���¹� �÷���. src ����� .swf�� ���� �ִ� ���� ������ ��ġ�� ������ ����Ŵ 
				���� .swf�� ���� �������� src�� �����ؼ� �ε�ȭ���� �����ִ� ���� ���� ��.
				������ �ε�ȭ���� ��� ���ٰ� �����ϱ� ��.
				�ش� �������� TIP�� �� �ִ�? ���� �ð��� �ȵ�;;; ��.. -->
			<iframe id="LowerFrame" 
				name="work" 
				style="display:none; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.jpg" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>