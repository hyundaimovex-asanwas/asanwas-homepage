<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>PMS>����ī��>��ǥ ����>��� ó��
 * ���α׷�ID 	 : PMS/CC110I
 * J  S  P		 : cc110ijsp, GAUCE5.x
 * �� �� ��		 : Cc110I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-08-21
 * [ �������� ][������] ����
 * [2015-07-30][�ɵ���] �ű� ���� 
 *						- �繫�� �����ڿ�, ��ü ī�� �����Ȳ ��ȸ
 *							�����Ȳ : �ۼ��� �� ������������� �� �������Ϸ�
 * [2015-08-04][�ɵ���] �� ó���ڿ�
 * [2015-08-25][�ɵ���]	�������� ����� ���԰�(TCC110)�� ���� [ó��]�� ������Ʈ	��
 *                      ���� ������ ���԰�(TCC110)�� ���� [��ó��]�� ������Ʈ	��
 * [2015-08-26][�ɵ���] �ŷ�ó ��� ��û���� �����ϱ� �ʿ�~! ()
 * [2015-08-26][�ɵ���] 6�� ���� ��ü ī�� �Ǽ� 43������ ��ǥ ���� �׽�Ʈ~ ��ǥ�� ����� 27�� 1,245,350��
 *						�������� ���� ��� �߰� ��
 *						to-do
 *							�ΰ���:�ſ�ī��(����) ������ ó�� : ȸ�� �� ���μ��� �����ϱ��
 *							��ǥ ���� �ڷ�(���γ���) �̱�
 * [2015-09-01][�ɵ���] ���� ���� : ��繬, ��ȿ��, ������, �̿���, ������ : �����Ȳ ���� �� ���� ����
 *						Ȩ>PMS>����ī��>��ǥ ����>��ǥ ����						
 *						��	���� �⺻���� ����ΰ� ����� üũ���ֱ�
 *						��	���� Y�� �͸� �ΰ��� ó��
 *						Ȩ>PMS>����ī��>��ǥ ����>��� ó��
 *							�������� ���� �����ϵ��� : �⺻�� N, �ΰ��� ������ Y
 *								�ΰ����� 0�̶� �Ϲ� ���� �ŷ�ó�� �Է� �����ϵ��� (Y)
 *								Y�� �ϴ� �ŷ�ó�� ��� �ŷ�ó ���+�Ϲ�N(����) �Ǿ�� ��
 *								��Ʈ : �ΰ���0���� ���ƿ�. ������ ���� ���� �Է� ó��
 *  �Ǻ���Բ�, �����ڷ� ���� + ��� �߾� ���� : ��ī ó�� ���μ��� ����, �ΰ��� ���� ����, �ǹ��� ���� ���
 *			��+Ƽ
 * [2015-09-01][�ɵ���] ���μ��� ���� �� ��������
 *						�� 1. [���λ��] ��ư �߰� : [��ó��]�� �͸� ���λ������ ��ȯ ����
 *						2. �ŷ�ó ��Ͽ�û
 *						�� 3. �������� �ϰ� ó�� : javascript
 *							��ϵ� �ŷ�ó && �Ϲ�(����) && ���� > 0 && [��ó��]]���¸� �� �������� Y
 *							PMS.TCC110���� EDI�Է½� ��������='F' �⺻�̹Ƿ�.. 
 *							ȭ�� ��ȸ �� [��ư] Ŭ���� ���� script ���� ok
 *						�� 4. ���� �� �������� üũ : javascript ���� ���ް����� ������ ����|�ͼ����� �Ѿ�� ��
 *						�� 5. ���ް���, ����, �����(�鼼��) ���� �Է� (��Ʈ ��) ó�� + �ݾ� üũ
 *							�� �ܰ迡�� ������ �׸��� �����ϰ� (���ް���, �ΰ��� �����, �������� �÷���. ó�����´� ���⼭ �ϴ°� �ƴԿ�~~!) 
 *						�� 6. �ŷ����� ����
 *						�� 7. ����|�ͼ����� ����
 * [2015-09-03][�ɵ���] ������ͼ� ���߰��� ������ �ΰ��� ������ �ȵǰ�
 *						�� �ϰ����� ��ư �߰�
 *						��꼭���� �� �����
 * [2015-09-10][�ɵ���] 9.9 1�� ����ȸ �� �ǵ�� �ݿ�
 *						��ó�� �� ���λ�� ��ȣ ������Ʈ
 *						���Ի��� ���� : ó�� �� ����, �ͼ��ڵ� ����
 * [2015-11-23][�ɵ���] ����|�ͼ������� ���� �߰� - ����, �ӽ� ������ ���� ó�� �Ϸ�
 * [2015-11-24][�ɵ���] �����ڵ� ������ TCC120���� PK�� ��ƾ� �� ��. �⺻�� 00����..
 *						TCC120_PK = (ACQUIRE_SID, PL_DEPT, ATCODE, REFCD)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ���� : doctype�� html5�� �غ���? ��;;-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	var menuWin;	//��â �����.
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
		cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail

		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    v_todt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    //v_todt.Text = "20150630";
	    //v_frdt.Text = "20150601";
	    

        ds_gc_ccstat.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC010&s_item1=Y";
        ds_gc_ccstat.Reset();	//ī�� ó������ CC010 (��ü+ : dsType=4) ����:dsType=3
        ds_gc_ddyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_gc_ddyn.Reset();	//�������� YN (SY010)

		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CUL=ds_cul,O:DS_CULD=ds_culd)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        fnSelect();
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var v_frdate = v_frdt.Text.trim();
        var v_todate = v_todt.Text.trim();
        

        if(v_frdate.length!=8||v_todate.length!=8) {
            alert("�ŷ����ڸ� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
        	+ ",v_mgr_no=" + v_mgr_no.value	//ó���� ���
			+ ",v_frdt=" + v_frdate	//��ȸ�Ⱓ
			+ ",v_todt=" + v_todate	//��ȸ�Ⱓ
			+ ",v_ccstat=" + lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)	//ó������
			+ ",v_card_num=" + v_card_num.value	//ī���ȣ
			+ ",v_acquire_sid="
			;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CUL=ds_cul)",
            param);
        tr_post(tr1);
    }

    
    <%// ������ �������� %>
    function fnSelectDetail(row) {
    	if(row>ds_cul.countrow){	//�տ��� ���� row�� ds_cul���� ũ��, �� ���ο� �������� ds_cul�� ��ȸ�� ��
    		row = 1;	//���� ������ ó��
    	}
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
        tr_post(tr2);
    }
    
    <%//������ �������� ���߰� %>
	function fnAddRowDt1(){
		if(ds_cul.RowPosition>0){
			//���������� �� ���ް��� = �ŷ� ���� ���ް��� + �����
			var totAmt = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC")
			var subAmt = 0;
			if(ds_culd.RowPosition==0){//���������� ���� ��
				subAmt = 0;
			}else{
				for(i=1;i<=ds_culd.countrow;i++) {
					subAmt += ds_culd.namevalue(i,"FSAMT");	
				}			
			}
			ds_culd.addrow();
			ds_culd.namevalue(ds_culd.RowPosition, "acquire_sid") 	= ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID");	
			ds_culd.namevalue(ds_culd.RowPosition, "FSAMT") 		= totAmt - subAmt;
			//ds_culd.namevalue(ds_culd.RowPosition,"REFCDNM")		= "����";
			ds_culd.namevalue(ds_culd.RowPosition,"REFCD")			= "00";
			if(v_memory_chk.checked){//üũ��. 1���� ���� �����ؼ� ����
				ds_culd.namevalue(ds_culd.RowPosition,"GROUP_NM")		= v_groupnm.value; 
				ds_culd.namevalue(ds_culd.RowPosition,"ATCODENM")		= v_atcodenm.value; 
				ds_culd.namevalue(ds_culd.RowPosition,"ATCODE")			= v_atcode.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REMARK")			= v_remark.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT_NM")		= v_pl_dept_nm.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT")		= v_pl_dept.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT_DIV")	= v_pl_dept_div.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REFCDNM")		= v_refcdnm.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REFCD")			= v_refcd.value ;
				
			}
			msgTxt.innerHTML="[��������] ���� �߰��Ǿ����ϴ�.";
			gr_culd.Focus();//���߰� �� �׸���� ��Ŀ��
		}else{
			alert("ī�� ���� ���� �����ϼž� ���������� �߰��� �� �ֽ��ϴ�.");
		}
    }
    <%//������ �������� ����� %>
	function fnDelRowDt1(){
		ds_culd.DeleteRow(ds_culd.RowPosition);
    }	
	
	<%//�������� �˻� ��%>
    function fnAtcodePopup(dirPath, row){
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		sendParam[0] = ds_culd.namevalue(row, "atcodenm");		<%//�˻� Ű���� ����:���� �����ڵ��%>
		sendParam[1] = "02";	<%//�����ڵ� : ����=02%>
    	strURL = dirPath+"/Account/jsp/actcode_popup_ifrm.jsp";
    	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);

    	if (arrResult != null) {
    	   	//alert(arrResult);
    		arrParam = arrResult.split(";");
    		if(arrParam[0]=="4402810"||arrParam[0]=="4402820"||arrParam[0]=="4331700"){//�������̸�
    			if(ds_cul.namevalue(ds_cul.RowPosition, "AMT_TAX")>0){
    				alert("������ ó���� ���� �ΰ����� '0'�̾�� �մϴ�.\n�������θ� üũ �����Ͻñ� �ٶ��ϴ�.");
    				ds_culd.undoall();
    				msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
    				return;		
    			}
    			ds_culd.namevalue(row, "refcd") 	= "006";	//������ �ڵ�
        		ds_culd.namevalue(row, "refcdnm") 	= "�ſ�ī��";	//������ �ڵ��
    		}
    		ds_culd.namevalue(row, "ATCODE") = arrParam[0];	//�����ڵ�
    		ds_culd.namevalue(row, "ATCODENM") = arrParam[1];	//������
        	ds_culd.namevalue(row, "refcd") 	= "00";	//������ �ڵ�
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//������ �ڵ��
    		
        } else {
        	ds_culd.namevalue(row, "ATCODE") = "";	//�����ڵ�
        	ds_culd.namevalue(row, "ATCODENM")= "";	//������
        	ds_culd.namevalue(row, "refcd") 	= "00";	//������ �ڵ�
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//������ �ڵ��
        	
        }               
    }
	<%//����-�����ڵ� �˻� �� 20150910%>
    function fnRefcodePopup(dirPath, row){
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
    	var atcd, fsrefcd;
    	atcd = ds_culd.namevalue(row, "atcode");//�ش�row�� �����ڵ�
    	//�����ڵ� �� ���� ����/////////////////////////
	    	if(atcd=="4402110")	fsrefcd="1022"	;	<%//�ǸŰ�����/�����Ļ��� 	�� 4. �����Ļ���%>
	    	if(atcd=="4402120")	fsrefcd="1022"	;	<%//�Ǹź�/�����Ļ���     	�� 4. �����Ļ���%>
	    	if(atcd=="4402130")	fsrefcd="1022"	;	<%//������/�����Ļ��� 	  	�� 3. �����Ļ���%>
	    	if(atcd=="4402210")	fsrefcd="1023"	;	<%//�ǸŰ�����/������� 	�� 4. �������%>
	    	if(atcd=="4402220")	fsrefcd="1023"	;	<%//�Ǹź�/�������     	�� 4. �������%>
	    	if(atcd=="4402230")	fsrefcd="1023"	;	<%//������/������� 	  	�� 3. �������%>
	    	if(atcd=="4402310") fsrefcd="1024" 	; 	<%//�ǸŰ�����/�����Ʒú�   �� 4. �����Ʒú�%>
	    	if(atcd=="4402320")	fsrefcd="1024"	;	<%//�Ǹź�/�����Ʒú�     	�� 8. �����Ʒú�%>
	    	if(atcd=="4402330")	fsrefcd="1024"	;	<%//������/�����Ʒú� 	  	�� 3. �����Ʒú�%>
	    	if(atcd=="4402410")	fsrefcd="1025"	;	<%//�ǸŰ�����/��ź�     	�� 4. ��ź� %>
	    	if(atcd=="4402420")	fsrefcd="1025"	;	<%//�Ǹź�/��ź�         	�� 4. ��ź� %>
	    	if(atcd=="4402430")	fsrefcd="1025"	;	<%//������/��ź�         	�� 4. ��ź� %>
	    	if(atcd=="4402510")	fsrefcd="1026"	;	<%//�ǸŰ�����/�繫��ǰ��     	�� 4. �繫��ǰ�� %>
	    	if(atcd=="4402520")	fsrefcd="1026"	;	<%//�Ǹź�/�繫��ǰ��         	�� 4. �繫��ǰ�� %>
	    	if(atcd=="4402530")	fsrefcd="1026"	;	<%//������/�繫��ǰ��         	�� 3. �繫��ǰ�� %>
	    	if(atcd=="4402610")	fsrefcd="1027"	;	<%//�ǸŰ�����/�Ҹ�ǰ��     	�� 4. �Ҹ�ǰ�� %>
	    	if(atcd=="4402620")	fsrefcd="1027"	;	<%//�Ǹź�/�Ҹ�ǰ��         	�� 4. �Ҹ�ǰ�� %>
	    	if(atcd=="4402630")	fsrefcd="1027"	;	<%//������/�Ҹ�ǰ��         	�� 3. �Ҹ�ǰ�� %>
	    	if(atcd=="4402710")	fsrefcd="1028"	;	<%//�ǸŰ�����/�����μ��     	�� 4. �����μ�� %>
	    	if(atcd=="4402720")	fsrefcd="1028"	;	<%//�Ǹź�/�����μ��         	�� 4. �����μ�� %>
	    	if(atcd=="4402730")	fsrefcd="1028"	;	<%//������/�����μ��         	�� 3. �����μ�� %>
	    	if(atcd=="4403210")	fsrefcd="1029"	;	<%//�ǸŰ�����/���ݰ�����     	�� 4. ���ݰ����� %>
	    	if(atcd=="4403220")	fsrefcd="1029"	;	<%//�Ǹź�/���ݰ�����         	�� 4. ���ݰ����� %>
	    	if(atcd=="4403230")	fsrefcd="1029"	;	<%//������/���ݰ�����         	�� 3. ���ݰ����� %>
	    	if(atcd=="4403310")	fsrefcd="1030"	;	<%//�ǸŰ�����/�����     	�� 4. ����� %>
	    	if(atcd=="4403320")	fsrefcd="1030"	;	<%//�Ǹź�/�����         	�� 4. ����� %>
	    	if(atcd=="4403330")	fsrefcd="1030"	;	<%//������/�����         	�� 3. ����� %>
	    	if(atcd=="4403410")	fsrefcd="1031"	;	<%//�ǸŰ�����/������     	�� 4. ������ %>
	    	if(atcd=="4403420")	fsrefcd="1031"	;	<%//�Ǹź�/������         	�� 4. ������ %>
	    	if(atcd=="4403430")	fsrefcd="1031"	;	<%//������/������         	�� 3. ������ %>
	    	if(atcd=="4403510")	fsrefcd="1032"	;	<%//�ǸŰ�����/����������     	�� 4. ���������� %>
	    	if(atcd=="4403520")	fsrefcd="1032"	;	<%//�Ǹź�/����������         	�� 4. ���������� %>
	    	if(atcd=="4403530")	fsrefcd="1032"	;	<%//������/����������         	�� 3. ���������� %>
	    	if(atcd=="4403610")	fsrefcd="1033"	;	<%//�ǸŰ�����/��������     	�� 4. �������� %>
	    	if(atcd=="4403620")	fsrefcd="1033"	;	<%//�Ǹź�/��������         	�� 4. �������� %>
	    	if(atcd=="4403630")	fsrefcd="1033"	;	<%//������/��������         	�� 3. �������� %>
	    	if(atcd=="4403710")	fsrefcd="1034"	;	<%//�ǸŰ�����/�����ݺ�     	�� 4. �����ݺ� %>
	    	if(atcd=="4403720")	fsrefcd="1034"	;	<%//�Ǹź�/�����ݺ�         	�� 4. �����ݺ� %>
	    	if(atcd=="4403730")	fsrefcd="1034"	;	<%//������/�����ݺ�         	�� 3. �����ݺ� %>
	    	if(atcd=="4403810")	fsrefcd="1035"	;	<%//�ǸŰ�����/������     	�� 4. ������ %>
	    	if(atcd=="4403820")	fsrefcd="1035"	;	<%//�Ǹź�/������         	�� 4. ������ %>
	    	if(atcd=="4403830")	fsrefcd="1035"	;	<%//������/������         	�� 3. ������ %>
	    	if(atcd=="4403910")	fsrefcd="1036"	;	<%//�ǸŰ�����/����������     	�� 4. ���������� %>
	    	if(atcd=="4403920")	fsrefcd="1036"	;	<%//�Ǹź�/����������         	�� 4. ���������� %>
	    	if(atcd=="4403930")	fsrefcd="1036"	;	<%//������/����������         	�� 3. ���������� %>
	    	if(atcd=="4404310")	fsrefcd="1039"	;	<%//�ǸŰ�����/�����     	�� 4. ����� %>
	    	if(atcd=="4404320")	fsrefcd="1039"	;	<%//�Ǹź�/�����         	�� 4. ����� %>
	    	if(atcd=="4404330")	fsrefcd="1039"	;	<%//������/�����         	�� 3. ����� %>
	    	if(atcd=="4404010")	fsrefcd="1144"	;	<%//�ǸŰ�����/��������     	�� 4. �������� %>
	    	if(atcd=="4404020")	fsrefcd="1144"	;	<%//�Ǹź�/��������         	�� 4. �������� %>
	    	if(atcd=="4404030")	fsrefcd="1144"	;	<%//������/��������         	�� 3. �������� %>
	    	if(atcd=="4402810")	fsrefcd="1103"	;	<%//�ǸŰ�����/����񱸺�     	�� 4. ����񱸺� %>
	    	if(atcd=="4402820")	fsrefcd="1103"	;	<%//�Ǹź�/����񱸺�         	�� 4. ����񱸺� %>
	    	if(atcd=="4402830")	fsrefcd="1103"	;	<%//������/����񱸺�         	�� 3. ����񱸺� %>
	    	
	    	if(atcd=="4330900")	fsrefcd="1022"	;	<%//�������/�����Ļ���   	�� 5. �����Ļ���%>
	    	if(atcd=="4331000")	fsrefcd="1023"	;	<%//�������/�������     �� 8. �������%>
	    	if(atcd=="4331100") fsrefcd="1024" 	; 	<%//�������/�����Ʒú�   	�� 5. �����Ʒú�%>
	    	if(atcd=="4331200")	fsrefcd="1025"	;	<%//�������/��ź�       	�� 5. ��ź�%>
	        if(atcd=="4331300") fsrefcd="1026" 	; 	<%//�������/�繫��ǰ��    	�� 5. �繫��ǰ��%>
	        if(atcd=="4331400") fsrefcd="1027" 	; 	<%//�������/�Ҹ�ǰ��    	�� 5. �Ҹ�ǰ��%>
	        if(atcd=="4331600") fsrefcd="1028" 	; 	<%//�������/�����μ��    	�� 5. �����μ��%>
	        if(atcd=="4332100") fsrefcd="1029" 	; 	<%//�������/���ݰ�����    	�� 5. ���ݰ�����%>
	        if(atcd=="4332200") fsrefcd="1030" 	; 	<%//�������/�����    		�� 5. �����%>
	        if(atcd=="4332300") fsrefcd="1124" 	; 	<%//�������/������    		�� 5. ������  2017.11.13 �̵��� ���� // �����׸� : ������ => �������������%>
	        if(atcd=="4332400") fsrefcd="1032" 	; 	<%//�������/����������    	�� 5. ����������%>
	        if(atcd=="4332500") fsrefcd="1033" 	; 	<%//�������/��������    	�� 5. ��������%>
	        if(atcd=="4332600") fsrefcd="1034" 	; 	<%//�������/�����ݺ�    	�� 5. �����ݺ�%>
	        if(atcd=="4332700") fsrefcd="1035" 	; 	<%//�������/������    		�� 5. ������%>
	        if(atcd=="4332800") fsrefcd="1036" 	; 	<%//�������/����������    	�� 5. ����������%>
	        if(atcd=="4333300") fsrefcd="1039" 	; 	<%//�������/�����    		�� 5. �����%>
	        if(atcd=="4333100") fsrefcd="1144" 	; 	<%//�������/��������    	�� 5. ��������%>
	        if(atcd=="4331700") fsrefcd="1103" 	; 	<%//�������/�����    	�� 5. ����񱸺�%>
    	//�����ڵ� �� ���� ����/////////////////////////    	
      
		sendParam[0] = fsrefcd;
		sendParam[1] = ds_culd.namevalue(row, "refcdnm");<%//�˻� Ű���� ����:���� �����%>
		strURL = dirPath+"/Account/jsp/commdtil_popup_ifrm.jsp";
    	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);
	   	//alert(arrResult);	//01;�߽�.�߱ٽĴ�; ;01
	   	if (arrResult != null) {
    		arrParam = arrResult.split(";");
    		ds_culd.namevalue(row, "refcd") 	= arrParam[0];	//������ �ڵ�
    		ds_culd.namevalue(row, "refcdnm") 	= arrParam[1];	//������ �ڵ��
        } else {
        	ds_culd.namevalue(row, "refcd") 	= "00";	//������ �ڵ�
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//������ �ڵ��
        }               
    }

    
	<%//�ͼ����� �˻� ��%>
    function fnPldeptPopup(dirPath, row){
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		sendParam[0] = ds_culd.namevalue(row, "pl_dept_nm");	<%//�˻� Ű���� ����:���� �ͼ��ڵ��%>
    	strURL = dirPath+"/Pms/help/cc110h_01.jsp";
    	strPos = "dialogWidth:490px;dialogHeight:339px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);

    	if (arrResult != null) {
    	   	//alert(arrResult);
    		arrParam = arrResult.split(";");
    		ds_culd.namevalue(row, "PL_DEPT_DIV") = arrParam[0];	//�ͼ��ڵ� ����
    		ds_culd.namevalue(row, "PL_DEPT") = arrParam[1];	//�ͼ��ڵ�
    		ds_culd.namevalue(row, "PL_DEPT_NM") = arrParam[2];	//�ͼ��ڵ��
        } else {
        	ds_culd.namevalue(row, "PL_DEPT_DIV") = "";	//�ͼ��ڵ� ����
        	ds_culd.namevalue(row, "PL_DEPT") = "";	//�ͼ��ڵ�
        	ds_culd.namevalue(row, "PL_DEPT_NM")= "";	//�ͼ��ڵ��
        }               
    }
    <%// �ű԰ŷ�ó ��� : ��%>
    function fnVendNew(Row){
		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		sendParam[0] = ds_cul.namevalue(Row, "VENDOR_TAX_NUM"); <%//��� Ű���� ����:����ڹ�ȣ%>
		sendParam[1] = ds_cul.namevalue(Row, "VENDOR_NAME"); <%//��� Ű���� ����:��������%>
		sendParam[2] = ds_cul.namevalue(Row, "VENDOR_PERSON"); <%//��� Ű���� ����:��ǥ��%>
		sendParam[3] = ds_cul.namevalue(Row, "VENDOR_TEL"); <%//��� Ű���� ����:��ȭ%>
		sendParam[4] = ds_cul.namevalue(Row, "VENDOR_ADDRESS1"); <%//��� Ű���� ����:�ּ�%>
		sendParam[5] = ds_cul.namevalue(Row, "COCOMYN"); <%//��� Ű���� ����: �ŷ�ó ��Ͽ�û ����%>
		strURL = "<%=dirPath%>/Pms/help/cc110h_02.jsp";
		strPos = "dialogWidth:340px;dialogHeight:530px;status:no;scroll:no;resizable:no";
		//alert(sendParam);
		arrResult = showModalDialog(strURL,sendParam,strPos);
		fnSelect();
	}
    <%// ���� ��꼭���� : ��%>
    function fnTaxPopup(Row){
		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		sendParam[0] = ds_cul.namevalue(Row, "TAXNBR").substring(0,1);   //���Ը��ⱸ�� (A-����, B-����)
		sendParam[1] = "02";                          //�����ڵ�
		sendParam[2] = ds_cul.namevalue(Row, "TAXNBR").substring(1,11);  //������ȣ
		sendParam[3] = "";   //��ǥ���ȣ
		sendParam[4] = "";   //�ŷ�ó�ڵ�
		sendParam[5] = "";   //�ŷ�ó��
		sendParam[6] = "103";  //������
		sendParam[7] = ds_cul.namevalue(Row, "TAXNBR");	//��꼭��ȣ
		strURL = "<%=dirPath%>/Account/jsp/a040110_view_popup.jsp";
		strPos = "dialogWidth:970px;dialogHeight:435px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
	}



    <%// ���λ�� ��ư: �ش� ��� ���� ���λ������ ���� %>
    function fnUsePrivate(){
    	if(ds_cul.RowPosition>0){
    		if(ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="01"||ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="03"){//��ó�� ����or���λ�����
    	    	v_job="UP"; //���λ��
    			ln_TRSetting(tr1, 
    					"<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
    					"JSP(I:DS_CUL_USE=ds_cul)",
    					"proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
    					+ ",v_acquire_sid="+ ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID")	
    					);
    			tr_post(tr1);
    		
    		}else{
        		alert("��ó��, ���λ�� ������ ��� �Ǹ� ������ �� �ֽ��ϴ�.")
        	}
    	}else{
    		alert("���õ� ī���� ���� �����ϴ�.");
    	}
    }

	<%// �ϰ����� ��ư - ��ϵ� �ŷ�ó && �Ϲ� && ���� > 0 && [��ó��] �� �������� Y   %>
    function fnSettle(){
		for(var i=1;i<=ds_cul.countrow;i++){
			if(ds_cul.namevalue(i,"COCOMYN")=="N"){	//��ϵ� �ŷ�ó && �Ϲ�(N)
				if(ds_cul.namevalue(i,"AMT_TAX")>0){	//���� > 0
					if(ds_cul.namevalue(i,"STAT")=="01"){//��ó��
						ds_cul.namevalue(i,"DDYN") = "T"; //�������� T�� ��ȯ						
					}
				}
			}
    	}
	}
    <%// �ϰ����� ��ư - ����T�� �ǵ� ���  %>
    function fnTaxCreate(){
    	//alert("�ϰ�����");
    	//�׸����� ���� �̸� �������ְ�
		for(var i=1;i<=ds_cul.countrow;i++){
			
			//alert(ds_cul.namevalue(i,"TAXYN"));
			if(ds_cul.namevalue(i,"STAT")=="02"&&ds_cul.namevalue(i,"DDYN")=="T"&&ds_cul.namevalue(i,"TAXYN")=="F"){	//���� TRUE�̸鼭 �������� ���� �͵�
				ds_cul.namevalue(i,"TAXYN") = "T"; //���Ի��� T�� ���� �� ����						
			}
    	}


    	//��������
		if (ds_cul.IsUpdated) {
			v_job=="AT";

			ln_TRSetting(tr1, 
	        	"<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
	            "JSP(I:DS_CULT=ds_cul)",
	            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	            		+ ",v_mgr_no=" + v_mgr_no.value	//ó���� ���
	            		+ ",v_mgr_deptcd=<%=(String)session.getAttribute("vdeptcd")%>"	//ó���� ��(ERP �α�� �μ�)
	            );

	        tr_post(tr1);
		}
    }    

    

	<%//���� %>
	function fnApply(){
		v_job = "A";
		//v_default_row = ds_culd.RowPosition;
		
		if (ds_culd.IsUpdated||ds_cul.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
                "JSP(I:DS_CUL=ds_cul, I:DS_CULD=ds_culd)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	+ ",v_acquire_sid="+ ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID")	
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%// ����� �Է°� üũ %>
	function ln_Chk() {
		var row1=ds_culd.countrow;
		var totAmt = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET") + ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC")	//ó�� ��� �ݾ�
		var subAmt = 0;
		var amt_total = ds_cul.namevalue(ds_cul.RowPosition,"AMT_TOTAL");//�̿�ݾ�
		var amt_use	  = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC");
		
		if(amt_total!=amt_use){//�ݾ��� ��ġ���� ���� ��
			alert("�̿�ݾװ� (���ް���+�ΰ���+�����)�� ��ġ���� �ʽ��ϴ�.\n�ٽ� Ȯ���� �ֽʽÿ�.");
			return;				
		}
		
		
		//prompt(this, ds_cul.text);
		
		
		
		//������ �׸��� üũ		
		if(ds_cul.namevalue(ds_cul.RowPosition,"ADDR1")=="�̵�� �ŷ�ó"&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			alert("�̵�� �ŷ�ó�� �������θ� üũ�� �� �����ϴ�.\n�ٽ� Ȯ���� �ֽʽÿ�.");
			return;				
		}
		
		/* 2018.02.13 ����ȣ ���� ��û���� �̵��� ���� */
		if(ds_cul.namevalue(ds_cul.RowPosition,"COCOMYN")=="T"&&ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")!=0){
			alert("���̰��� ��ü�� ��� �ΰ����� 0���� ������ֽñ� �ٶ��ϴ�.");
			return;				
		}			
		
		
		if(ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")==0&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			alert("�ΰ����� ' 0 ��' �̸� �������θ� üũ�� �� �����ϴ�.\n�ٽ� Ȯ���� �ֽʽÿ�.");
			return;				
		}
		
	
		
		
		
		for(i=1;i<=row1;i++) {//����|�ͼ����� üũ
			if(ds_culd.namevalue(i,"GROUP_NM")==""){
				alert("���������� ó���׷���� �Էµ��� �ʾҽ��ϴ�.");
				return;				
			}

			if(ds_culd.namevalue(i,"PL_DEPT")==""){
				alert("���������� �ͼ������� ���������� �Էµ��� �ʾҽ��ϴ�.\n�˻� â�� �̿��� �ٽ� �Է��� �ֽʽÿ�.");
				return;				
			}

			if(ds_culd.namevalue(i,"ATCODE")==""){
				alert("���������� �������� ���������� �Էµ��� �ʾҽ��ϴ�.\n�˻� â�� �̿��� �ٽ� �Է��� �ֽʽÿ�.");
				return;				
			}			

			if(ds_culd.namevalue(i,"REMARK")==""){
				alert("���������� ���䰡 �Էµ��� �ʾҽ��ϴ�. �ٽ� Ȯ���� �ֽʽÿ�.");
				return;				
			}
			
			if(ds_culd.namevalue(i,"FSAMT")==0){
				alert("���������� ���ް����� 0 �Դϴ�. �ٽ� Ȯ���� �ֽʽÿ�.");
				return;				
			}
			
			subAmt += ds_culd.namevalue(i,"FSAMT");//���ް����� �հ�  ����ġ üũ
		}
		
		if(row1>0&&totAmt!=subAmt) {
			alert("���������� ���ް��� ��("+subAmt+")�� �ΰ����� ������ ī���� �ݾ�("+totAmt+")�� ��ġ���� �ʽ��ϴ�.");
			return;
		}
		
		
		if(v_memory_chk.checked){//üũ��. 1���� ���� �����ؼ� ����
			v_groupnm.value 	= ds_culd.namevalue(1,"GROUP_NM");
			v_atcodenm.value 	= ds_culd.namevalue(1,"ATCODENM");
			v_atcode.value 		= ds_culd.namevalue(1,"ATCODE");
			v_remark.value 		= ds_culd.namevalue(1,"REMARK");
			v_pl_dept_nm.value 	= ds_culd.namevalue(1,"PL_DEPT_NM");
			v_pl_dept.value 	= ds_culd.namevalue(1,"PL_DEPT");
			v_pl_dept_div.value = ds_culd.namevalue(1,"PL_DEPT_DIV");
			v_refcdnm.value 	= ds_culd.namevalue(1,"REFCDNM");
			v_refcd.value 		= ds_culd.namevalue(1,"REFCD");
		}
		return true;
	}    

	
	function fnCancel() {
		ds_cul.undoall();
		ds_culd.undoall();
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	
	<%// ī���ȣ �˻����� �ʱ�ȭ %>
	function fnCardNoCleanup(){
    	v_card_num.value = "";
    }

	
    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }


    <%//��ǥ ���� Ŭ����%>
    function fnStateCreate(){
    	
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		

    	
		strURL = "<%=dirPath%>/Pms/new/sta/sta210.jsp";
		
    	strPos = "dialogWidth:1050px;dialogHeight:800px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		

    		
        } else {
        	

			
        }    
        
        
    }
    
    
    
    
    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=v_todt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>

	<%//������ �׸��� OnClick : ����|�ͼ����� ��ȸ %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectDetail(Row);
	    }
	</script>
	
	<%//������ �׸��� OnDblClick : �ŷ�ó ��� ��û ��%>
	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
		if(Colid=="ADDR1"&&ds_cul.NameValue(Row, "VEND_NM")==""){
			fnVendNew(Row);			
		}
		if(Colid=="TAXYN"&&ds_cul.NameValue(Row, "TAXYN")=="T"){
			fnTaxPopup(Row);
		}
	</script>

	<%//������ �׸��� / �������� OnCheckClick %>
	<script language="javascript"  for=gr_cul event=OnCheckClick(Row,Colid,Check)>
    	<%	// �������� üũ�� ���� �ڵ����
			//		��ó�� ���� + �Ϲݰ��� �� �͸� �۵��� %>
		//if(ds_cul.namevalue(Row,"STAT")=="01"&&ds_cul.namevalue(Row,"COCOMYN")=="N"){
			//alert(Check);
			//alert(ds_cul.namevalue(Row,"AMT_TAX_BC"));
		if(ds_cul.namevalue(Row,"STAT")=="01"){
			if(Check=="1"){	//AMT_TAX_BC �÷����� �缳��:20151215
				//ds_cul.namevalue(Row,"AMT_TAX") = ds_cul.namevalue(Row,"AMT_TAX_BC") ;
				//ds_cul.namevalue(Row,"AMT_NET") = ds_cul.namevalue(Row,"AMT_TOTAL") - ds_cul.namevalue(Row,"AMT_TAX_BC");
				
			}else{
				ds_cul.namevalue(Row,"AMT_NET") = ds_cul.namevalue(Row,"AMT_TOTAL");
				ds_cul.namevalue(Row,"AMT_TAX") = 0;
				ds_cul.namevalue(Row,"AMT_SVC") = 0;
			}
		}else{
			//alert("�������θ� �����Ϸ���, [�Ϲ�]���� �ŷ�ó�̰�,\nó�����°� [��ó��]���� �մϴ�.")
			alert("�������θ� �����Ϸ���, ó�����°� [��ó��]���� �մϴ�.");
			
			ds_cul.namevalue(Row,"DDYN") = "F";
		}
		/*		BOOL check : Click�� CheckBox�� üũ�� ����(1 : üũ�� ����, 0 : üũ������ ����)
	    			 �÷����� T,F�� �۵� T=üũ����
		*/
	</script>
	
	<%//������ �׸��� / �������� OnCheckClick %>
	<script language="javascript"  for=gr_cul event=CanColumnPosChange(Row,Colid)>
		var amt_total = ds_cul.namevalue(Row,"AMT_TOTAL");
		var amt_use	  = ds_cul.namevalue(Row,"AMT_NET")+ds_cul.namevalue(Row,"AMT_TAX")+ds_cul.namevalue(Row,"AMT_SVC");
		/*if(amt_total!=amt_use){//�ݾ��� ��ġ���� ���� ���� ���ް���, �ΰ����� ������ ��� �� ����
			if(Colid=="AMT_NET"){
				ds_cul.namevalue(Row,"AMT_TAX") = Math.round(ds_cul.namevalue(Row,"AMT_NET")/10);	//����=���ް���=1/10
				ds_cul.namevalue(Row,"AMT_SVC") = ds_cul.namevalue(Row,"AMT_TOTAL") - ds_cul.namevalue(Row,"AMT_NET") - ds_cul.namevalue(Row,"AMT_TAX"); //����Ὺ��
				return true;
			//}else if(Colid=="AMT_TAX"){
				//return true;
			}else{
				alert("���ް���+�ΰ���+������� ���� �̿�ݾװ� ��ġ���� �ʽ��ϴ�.\n\n���� ������ ��ҵ˴ϴ�.");
				fnCancel();
				//return false;				
			}
		}*/
	</script>

	
	

	<%//������ : �˾�  %>	
	<script language=JavaScript for=gr_culd event=OnPopup(row,colid,data)>
		if(colid=="ATCODENM") {
			//alert(row);
			fnAtcodePopup('<%=dirPath%>', row);
		}
		if(colid=="PL_DEPT_NM") {
			//alert(row);
			fnPldeptPopup('<%=dirPath%>', row);
		}
		if(colid=="REFCDNM") {
			//alert(row);
			fnRefcodePopup('<%=dirPath%>', row);
		}

	</script>



<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"||v_job=="UP"||v_job=="AT"){
		alert("���������� ����Ǿ����ϴ�.");
		fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_cul" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_cul event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
				
				<%//ó�� ���·� ��ȸ �Ϸ�ÿ��� �ϰ����� ��ư ���̱� 20150910%>
				if(lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)=="02"){
					document.getElementById("butTax").style.display = "inline";
				}else{
					document.getElementById("butTax").style.display = "none";
				}
			}
		}
	</script>
    	
    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_culd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_ccstat	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_ddyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=left >&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/sta_issue.gif"				style="cursor:pointer" onClick="fnStateCreate();">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"			style="cursor:pointer" onclick="fnSelect()">
							<!--  <img src="<%=dirPath%>/Sales/images/use_private.gif" 	style="cursor:pointer" onClick="fnUsePrivate();"> -->
							<img src="<%=dirPath%>/Sales/images/taxCal.gif" 		style="cursor:pointer" onClick="fnSettle();">
							<img src="<%=dirPath%>/Sales/images/taxCreate.gif" 		id="butTax" style="cursor:pointer;display:none;" onClick="fnTaxCreate();">
							<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"			style="cursor:pointer"  onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1002px'>
           			<tr>
                        <td align="center" class="text" width="60">ó����</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrid")%>">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:45px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrnm")%>">
                        	<%=(String)session.getAttribute("vdeptnm")%>(<%=(String)session.getAttribute("vdeptcd")%>)
                        	<% if("CC20".equals((String)session.getAttribute("vdeptcd"))){%>
                        	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                            <%}%>
                        </td>

                        <td align="center" class="text" width="60">�ŷ�����</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=v_frdt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            &nbsp;~&nbsp;
                            <object id=v_todt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>                            
                            
                        </td>
                        <td align="left" class="text" width="60">ó�� ����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_ccstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_ccstat>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                                                        
                        </td>                                

                        <td align="center" class="text" width="60">ī���ȣ</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="�� �����">
                        </td>

					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">

                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='380px' border='1'>
                    <param name="DataID"            value="ds_cul">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"       	value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="ViewSummary"       value="1">
                    <Param Name="SortView"     		value="Right">
                    <Param Name="UsingOneClick"     value="1">
   					<param name="ColSelect"    		value="True">																								                                        
					<param name="SelectionColor"    value="
						<SC>Type='FocusEditCol', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', 		BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', 		BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', 			BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', 			BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', 			BgColor='#D1DEF0', TextColor='Black'</SC>
					">
                    <param name="Format"            value="
						<C> name='No'			 		ID='{CurRow}'		 	width=30 	align=CENTER  	edit=none sumtext=@cnt </C>
                        <C> name='ó����'		 		ID='MGR_NM'   		 	width=50 	align=CENTER  	edit=none show=false</C>
                        <C> name='����SId'		 		ID='ACQUIRE_SID'		width=50 	align=left 		show=false</C>
                        <C> name='ī��\\������' 		ID='EMP_NM'   		 	width=55 	align=CENTER 	edit=none bgColor={IF(EMP_NM='�̵��','#ffcccc','#FFFFFF') } sumtext='��' </C>
                        <C> name='ī���ȣ'	 			ID='CARD_NUM'  	 		width=130 	align=CENTER	edit=none mask='XXXX-XXXX-XXXX-XXXX' sort=true </C>
					  <G> name='�ŷ�ó ���� (ERP)'
                        <C> name='��ȣ'					ID='VEND_NM'   			width=85 	align=left		edit=none  sort=true </C>
                        <C> name='�ּ�'					ID='ADDR1'   			width=80 	align=left		edit=none bgColor={IF(ADDR1='�̵�� �ŷ�ó','#ff3300','#FFFFFF') } </C>
                        <C> name='����'					ID='COCOMYN_NM'   		width=40 	align=CENTER	edit=none </C>
                      </G>
                      <G> name='�̿�����'
                        <C> name='����'					ID='APPROVE_DATE'	 	width=80 	align=CENTER 	edit=none 	mask='XXXX-XX-XX'</C>
                        <C> name='�ð�'					ID='APPROVE_TIME'	 	width=40 	align=CENTER 	edit=none 	mask='XX:XX'</C>
                        <C> name='�ݾ�'     			ID='AMT_TOTAL'			width=70 	align=right		Edit=NONE	 decao=0  sort=true  sumtext=@sum </C>
                      </G>
                        <C> name='���ް���'     		ID='AMT_NET'			width=70 	align=right		Edit=true	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
                        <C> name='�ΰ���'    			ID='AMT_TAX'			width=60 	align=right		Edit=tree	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
                        <C> name='�����\\(�鼼��)'    	ID='AMT_SVC'			width=60 	align=right		Edit=true	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
						<C> name='ó��\\����'   		ID='STAT'   			width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_ccstat:detail:detail_nm' SumText={sum(AMT_NET)+sum(AMT_TAX)+sum(AMT_SVC)} SumTextColor='#ff0000' </C>
						<C> name='����\\����'			ID='DDYN'   			width=40 	align=CENTER	edit=true editstyle=CheckBox  bgColor={IF(DDYN='T','#CCFFCC','#FFFF00') } </C>
						<C> name='����\\����'			ID='TAXYN'   			width=40 	align=CENTER	edit=none editstyle=CheckBox  bgColor={IF(TAXYN='T','#CCFFCC','#FFFFFF') } </C>
						<C> name='��ȭ'					ID='CURRENCY'   	 	width=40 	align=CENTER  	edit=none</C>
					  <G> name='������ ���� (BC����)'
						<C> name='����ڹ�ȣ'			ID='VENDOR_TAX_NUM'  	width=80 	align=left		edit=none mask='XXX-XX-XXXXX' show=false</C>
						<C> name='��������'				ID='VENDOR_NAME'	 	width=100 	align=left		edit=none show=false</C>
						<C> name='��ǥ��' 				ID='VENDOR_PERSON'   	width=50 	align=center 	edit=none show=false</C>
						<C> name='��ȭ'					ID='VENDOR_TEL'   		width=80 	align=left		edit=none show=false</C>
						<C> name='�ּ�'					ID='VENDOR_ADDRESS1'   	width=100 	align=left		edit=none show=false</C>
					  </G>
					    <C> name='BC\\�ΰ���'    		ID='AMT_TAX_BC'			width=60 	align=right		decao=0   show=false</C>
                 ">                             
                </object>                        

            </td>
        </tr>
		<tr>
			<td height='31px' class="r bold"><!-- �������� �ӽú����� -->

			<br>
					��������<input type="checkbox" name='v_memory_chk' id="v_memory_chk" ><input type="text" name="v_groupnm" 	id="v_groupnm" 	  style="width:140px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_pl_dept_nm" 	id="v_pl_dept_nm"  style="width:100px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_pl_dept" 	id="v_pl_dept" 	   style="width:40px;" class="input01"  readOnly="readonly" value="">				
					<input type="text" name="v_pl_dept_div" id="v_pl_dept_div" style="width:20px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_atcodenm" 	id="v_atcodenm"    style="width:130px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_atcode" 		id="v_atcode" 	   style="width:50px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_refcdnm" 	id="v_refcdnm"     style="width:90px;" class="input01"  readOnly="readonly" value="">				
					<input type="text" name="v_refcd" 		id="v_refcd" 	   style="width:40px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_remark" 		id="v_remark" 	   style="width:140px;" class="input01"  readOnly="readonly" value="">				
				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt1()" >
			</td>
		</tr>        
        
        <tr>
            <td valign="top">
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='60px' border='1'>
                    <param name="DataID"            value="ds_culd">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
						<C> name='No'			ID='{CurRow}'		width=30 	align=right 	edit=none sumtext=@cnt </C>
						<C> name='ó�� �׷��'	ID='GROUP_NM'		width=140 	align=left </C>
                        <C> name='�ͼ�����'		ID='PL_DEPT_NM' 	width=170 	align=left 		EditStyle=popup </C>
                        <C> name='�ͼ��ڵ�'		ID='PL_DEPT' 		width=70	align=center  	edit=none show=true  bgcolor=#9e9e9e show=false</C>
                        <C> name='�ͼӱ���'		ID='PL_DEPT_DIV'	width=60 	align=CENTER 	show=false	</C>
                        <C> name='������'		ID='ATCODENM'		width=150 	align=left 		EditStyle=popup </C>
                        <C> name='�����ڵ�'		ID='ATCODE'			width=70 	align=center 	edit=none bgcolor=#9e9e9e show=false</C>
                        <C> name='�����'		ID='REFCDNM'		width=120 	align=left 		EditStyle=popup </C>
                        <C> name='�����ڵ�'		ID='REFCD'			width=60 	align=center 	edit=none bgcolor=#9e9e9e show=false</C>
                        <C> name='����'			ID='REMARK'   		width=250 	align=left </C>
                        <C> name='���ް���' 	ID='FSAMT'			width=100 	align=right		decao=0  </C>
                        <C> name='����SID'		ID='acquire_sid'	width=60 	align=CENTER	edit=none show=false </C>
                        
                 ">                             
                </object>                        
            </td>
        </tr>
        <tr>
            <td valign="top"><br>
		            �� ��������<b>�� Check</b>�ϸ�, ����� ���������� �����Ͽ�, �ݺ� �۾��� �����մϴ�. ������ ���� ������ <b>�����ڵ�="00"</b>�� �⺻���Դϴ�.<br>
		            �� ó�� ���μ���<br>
            ��			1. �� �� �񡡡�: ������ ó���� ��� ���� �������θ� üũ��üũ�����Ͽ� <b>�ΰ����� 0</b>���� ������ �մϴ�.<BR>
 			��	2. ���� ó��<br>
 			����		1) �� �� ó��: �ΰ��� ������ ��� �� �� <b>�̵�� �ŷ�ó</b>�� �ִٸ� �ŷ�ó ��Ͽ�û�� �մϴ�.<br>
 			����		2) �ϰ� ���� : �Ϲݰ��� �ŷ�ó�� <b>��ó�� and �ΰ����� 0���� ū</b> ��� �ǵ��� �ϰ����� ó���մϴ�.<br>
 			����		3) ���� ���� : ��Ʈ ��� �� �ΰ����� �������� ���� ��� �� �� �������� ���� ó���մϴ�.(������ ���� �ݾ� ���� �Է�, <b>�ǹ� ������</b> �ʿ�)<br>
			��	3. ���� ������ : �������� ó���� ��ģ �Ŀ� �� ��� ���� ���������� �����ϸ� ���°� [ó��]�� ����˴ϴ�.<br>
			��	4. ���� ������ : [�ϰ�����] ��ư�� ������, �������ΰ� üũ�� �� ��� ��꼭������ �ڵ����� �����մϴ�.
            </td>
        </tr>

    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		