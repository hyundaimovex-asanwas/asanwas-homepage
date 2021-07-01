package sales.common;

public class HDConstant_bk20080209 { 
    /**
     * �� ȭ���� Ŀ�ǵ忡�� ����� ������ ���� �������
     */
    public static final String PROCESS_TYPE_INIT = "INIT";     // �ʱ�ȭ
    public static final String PROCESS_TYPE_SEARCH = "S";    // ��ȸ
    public static final String PROCESS_TYPE_APPLY = "A";     // ����
    public static final String PROCESS_TYPE_INSERET = "I";     // ���
    public static final String PROCESS_TYPE_DELETE = "D";     // ����
    public static final String PROCESS_TYPE_UPDATE = "U";     // ����
    
    public static final String PROCESS_TYPE_MODIFY = "M";     // ��
    public static final String PROCESS_TYPE_EDIT = "E";     // �������� �� 
    public static final String PROCESS_TYPE_REPLY = "R";     // �亯
    
    /**
	 * Excel ����
	 */
	public static final String PROCESS_TYPE_EXCEL_CUSTOMER = "xsl_cust";	// �� ����
	public static final String PROCESS_TYPE_EXCEL_RESERVATION = "xsl_res"; // ���� ���� 

    /**
     * �� ���� ���
     */
    
	// ���� : request.getContextPath() = "/erp"
/*	
	//2007-07-23 ERP �޴� ����
    public static final String PATH_ERP_COMMON = "/services/servlet/common.";

    //sales �н�
    public static final String PATH_AC = "/services/servlet/sales.menu.ac.";
    public static final String PATH_BU = "/services/servlet/sales.menu.bu.";
    public static final String PATH_CQ = "/services/servlet/sales.menu.cq.";
    public static final String PATH_CU = "/services/servlet/sales.menu.cu.";
    public static final String PATH_MI = "/services/servlet/sales.menu.mi.";
    public static final String PATH_RM = "/services/servlet/sales.menu.rm.";
    public static final String PATH_RV = "/services/servlet/sales.menu.rv.";
    public static final String PATH_SY = "/services/servlet/sales.menu.sy.";
    public static final String PATH_HELP = "/services/servlet/sales.menu.help.";
    public static final String PATH_SAMPLE = "/services/servlet/sales.sample.";
	public static final String PATH_COMMON = "/services/servlet/sales.common.";
*/	
    
    // ���Ⱑ erp ��.. :request.getContextPath() ="/services"
	
	//2007-07-23 ERP �޴� ����
    public static final String PATH_ERP_COMMON = "/servlet/common.";

    //sales �н�
    public static final String PATH_AC = "/servlet/sales.menu.ac.";
    public static final String PATH_BU = "/servlet/sales.menu.bu.";
    public static final String PATH_CQ = "/servlet/sales.menu.cq.";
    public static final String PATH_CU = "/servlet/sales.menu.cu.";
    public static final String PATH_MI = "/servlet/sales.menu.mi.";
    public static final String PATH_RM = "/servlet/sales.menu.rm.";
    public static final String PATH_RV = "/servlet/sales.menu.rv.";
    public static final String PATH_SY = "/servlet/sales.menu.sy.";
    public static final String PATH_HELP = "/servlet/sales.menu.help.";
    public static final String PATH_SAMPLE = "/servlet/sales.sample.";
    public static final String PATH_COMMON = "/servlet/sales.common.";


    /**
     * Message
     */
    public static final String A_MSG_CHANGE_DATA 	= "�ڷᰡ ����Ǿ����ϴ�. ��ҶǴ� �����Ͻʽÿ�"; 		// alert ������ ��ȸ��, ������ �� �߰��� 
    public static final String A_MSG_SAVE_DONE 		= "�ڷḦ �����Ͽ����ϴ�.";							// ����
    public static final String A_MSG_MUST_INPUT 	= "��(��) ��Ȯ�� �Է��Ͻʽÿ�.";						// �ʼ� �Է��׸� �� �Է½�
    
    public static final String AS_MSG_DELETE_DONE 	= "�ڷḦ �����Ͽ����ϴ�.";							// ������
    public static final String AS_MSG_SEARCH_ERR 	= "��ȸ�� ������ �߻��Ͽ����ϴ�.";						// ��ȸ�� ����
    
    public static final String S_MSG_CANCEL_DONE 	= "�ڷ� ������ ��ҵǾ����ϴ�.";						// ���
    public static final String S_MSG_SAVE_DONE 		= "�۾��� ���������� �Ϸ�Ǿ����ϴ�.";					// �۾�����
    public static final String S_MSG_SAVE_ERR 		= "�۾��� ������ �߻��Ͽ����ϴ�";						// �۾�����
    public static final String S_MSG_SEARCH_DATA 	= "��ȸ ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";			// ��ȸ��
    public static final String S_MSG_SEARCH_DONE 	= "��ȸ�� �Ϸ� �Ǿ����ϴ�.";							// ��ȸ�Ϸ�
    public static final String S_MSG_NO_DATA 		= "��ȸ�� ������ �����ϴ�.";							// �����Ͱ� ���� ���
   
    public static final String C_MSG_ASK_DELETE 	= "�����Ͻðڽ��ϱ�?";									// ������ 
    
	/**
	 * Components 
	 */
    public static final String CT_GRID_CLSID 			= "'clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/toinbgrid.cab#version=1,1,1,173'";
    public static final String CT_EMEDIT_CLSID			= "'clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'";
    public static final String CT_TREEVIEW_CLSID		= "'clsid:4401B994-DD33-11D2-B539-006097ADB678' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/toinbtree.cab#version=1,1,1,40'";
    public static final String CT_LUXECOMBO_CLSID		= "'clsid:60109D65-70C0-425C-B3A4-4CB001513C69' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/LuxeCombo.cab#version=1,1,1,63'";
    public static final String CT_MENU_CLSID			= "'clsid:7A54CBF0-2CB4-11D4-973E-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbMenu.cab#version=1,1,1,25'";
    public static final String CT_TEXTAREA_CLSID		= "'clsid:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTextArea.cab#version=1,1,1,23'";
    public static final String CT_RADIO_CLSID			= "'clsid:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbRadio.cab#version=1,1,1,24'";
    public static final String CT_TAB_CLSID				= "'clsid:ED382953-E907-11D3-B694-006097AD7252' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTab.cab#version=1,1,1,20'";
    public static final String CT_REPORT_CLSID			= "'clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/toinbrep.cab#version=1,1,1,82'";
    public static final String CT_DATASET_CLSID			= "'clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbData.cab#version=1,1,1,51'";
    public static final String CT_TR_CLSID				= "'clsid:0A2233AD-E771-11D2-973D-00104B15E56F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTR.cab#version=1,1,1,49'";
    public static final String CT_IMG_DATASET_CLSID		= "'clsid:BCB3A52D-F8E7-11D3-973E-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbImgData.cab#version=1,1,1,20'";
    public static final String CT_INPUT_FILE_CLSID		= "'clsid:69F1348F-3EBE-11D3-973D-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbIFile.cab#version=1,1,1,17'";
	public static final String CT_BINDER_CLASSID 		= "'clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbBind.cab#version=1,1,1,18'";
	
	/**
	 * IE ��ġ ������ �±� 
	 */
	public static final String COMMENT_START 	= "<comment id=\"__NSID__\">";
	public static final String COMMENT_END 		= "</comment><script>__WS__(__NSID__);</script>";
	
	/**
	 * �׸��� ȯ�� ���� 
	 */
	public static final String GRAD_HEAD_CONFIG = "HeadAlign=Center HeadBgColor=#b8d2ed"; // �׸��� ��� ��ġ �� ��
	public static final String GRAD_ERR_COLOR 	= "#FF00FF";
	public static final String GRAD_OK_COLOR 	= "#FFFFFF";
	public static final String GRID_LINK_COLOR 	= "#1579C7";
	public static final String GRID_SUM_COLOR 	= "#F0EE90";
	public static final String GRID_ITEM = "#FEFEC0" ;
	
	public static final String GRID_TOUR_COLOR 	= "#F0EE90";	//RV200I ������ ���
	
	/**
	 * ���ϰ��
	public static final String FILE_UPLOAD_PATH_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/photo/cust/"; // ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_COST = "/Sales/file/photo/cust/"; // ���� 
	 */

	//�迵��
	// ���ÿ�
//	public static final String FILE_UPLOAD_PATH_COST = "C:/project/HDASAN/solbinet/WebContent/Sales/file/photo/"; // ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_COST = "/Sales/file/photo/"; // ���� 
//	
//	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/excel/cust/"; // ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "/Sales/file/excel/cust/"; // ���� 
	
	// �Ǽ����� 

//	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/was/web/salesagent/Sales/file/excel/cust/"; // ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "/Sales/file/excel/cust/"; // ���� 
	
	
//	public static final String FILE_UPLOAD_PATH_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/photo/cust/"; // ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/photo/cust/"; // ���� 
	
	
	// �׽�Ʈ 2
//	public static final String FILE_UPLOAD_PATH_COST = "/was/web/salesagent/Sales/file/photo/cust/"; 		// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_COST = "/Sales/file/photo/cust/"; 						// ���� 
//	
//	public static final String FILE_UPLOAD_PATH_DRIVE = "/was/web/salesagent/Sales/file/photo/drive/"; 		// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_DRIVE = "/Sales/file/photo/drive/"; 						// ���� 
//	
//	public static final String FILE_UPLOAD_PATH_CAR = "/was/web/salesagent/Sales/file/photo/car/"; 		// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_CAR = "/Sales/file/photo/car/"; 						// ���� 
//	
//	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/was/web/salesagent/Sales/file/excel/cust/"; 	// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "/Sales/file/excel/cust/"; 					// ���� 

	
	// kgs
	public static final String FILE_UPLOAD_PATH_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust/"; 		// ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_COST = "http://erp.hdasan.com/services/Sales/file/photo/cust/"; 						// ���� 
	
	public static final String FILE_UPLOAD_PATH_DRIVE = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/drive/"; 		// ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_DRIVE = "http://erp.hdasan.com/services/Sales/file/photo/drive/"; 						// ���� 
	
	public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/"; 		// ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_CAR = "http://erp.hdasan.com/services/Sales/file/photo/car/"; 						// ���� 
	
	//erp excel
	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// ���� ���� ��� �׼�
	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "http://erp.hdasan.com/services/Sales/file/excel/cust/"; 					// ���� 
	
	//199 excel
//	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebASE51/ASE/HDASAN/installedApps/WWW_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/"; 	// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "http://203.242.32.199/db2samples/Sales/file/"; 					// ���� 
	
	//local excel
//	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "D:/HDASan3/HDASan/WebContent/Sales/file/excel/cust/"; 	// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "/Sales/file/excel/cust/"; 					// ����
	
	
//	public static final String FILE_UPLOAD_PATH_CARD = "/QIBM/UserData/WebASE51/ASE/HDASAN/installedApps/WWW_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/card/";
//	public static final String FILE_DOWNLOAD_PATH_CARD = "http://erp.hdasan.com/services/Sales/file/card/";
	
//	public static final String FILE_UPLOAD_PATH_NOTICES = "/QIBM/UserData/WebASE51/ASE/HDASAN/installedApps/WWW_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/notices/"; 	// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_NOTICES = "http://erp.hdasan.com/services/Sales/file/notices/"; 					// ����
	
	public static final String FILE_UPLOAD_PATH_REQ = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/req/"; 		// ���� ���� ��� ��������
	public static final String FILE_DOWNLOAD_PATH_REQ = "http://erp.hdasan.com/services/Sales/file/photo/req/"; 						// ���� 
	
//	public static final String FILE_UPLOAD_PATH_REQ = "C:/"; 		// ���� ���� ��� ��������
//	public static final String FILE_DOWNLOAD_PATH_REQ = "C:/"; 						// ���� 	
	
//	public static final String FILE_UPLOAD_PATH_NOTICES = "D:/MyArea/02 Project/WorkSpace/Java/HDASanAgent/WebContent/Sales/file/notices/"; 	// ���� ���� ��� ������
//	public static final String FILE_DOWNLOAD_PATH_NOTICES = "/Sales/file/notices/"; 					// ����
	public static final String FILE_UPLOAD_PATH_NOTICES = "D:/HDASan3/HDASan/WebContent/Sales/file/notices/"; 	// ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_NOTICES = "/Sales/file/notices/"; 					// ����
	
	public static final String FILE_UPLOAD_PATH_CARD = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/card/sndFile/";
	public static final String FILE_DOWNLOAD_PATH_CARD = "http://erp.hdasan.com/services/Sales/file/card/sndFile/";

	
	/**
	 * ���� ���翡 �ʿ��� ��� ����
	 * ����� ���߱⿡ ���ؼ��� ������
	 */
	//erp / �븮�� ����...
	public static final String 	KCP_CAT_ID 		= "1000010473";			//KCP �ο��� �ܸ��� ��ȣ
	public static final String 	KCP_TERM_ID 	= "W6677";				//������� ������ü / ������� ������ �ʿ��� �͹̳� ��ȣ
	public static final String 	KCP_MIDBY_KCP 	= "2duv8V.4exyhnWO1O2nRFo4__";				//������� ������ü / ������� ������ �ʿ��� ������ ��ȣ
	
	public static final String 	KCP_TERM_ID1 	= "W8253";				//�����ݰ��� ������ü / ������� ������ �ʿ��� �͹̳� ��ȣ
	public static final String 	KCP_MIDBY_KCP1 	= "3LoujO7iZ1UhkdHh.-xC47F__";				//�����ݰ��� ������ü / ������� ������ �ʿ��� ������ ��ȣ
	
	public static final String KCP_CARD_AUTH = "http://com.hdasan.com/cEDI_card.asp";				//ī�� ���� URL		
	public static final String KCP_ACCOUNT_AUTH = "http://com.hdasan.com/cPlugOrder.asp";			//������ü �� ������� ���� URL
	
	//	���� ����...
	//public static final String KCP_RETURN_URL = "http://localhost/HDAsan/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
	
	//	erp ����...
	public static final String KCP_RETURN_URL = "http://erp.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
//	public static final String FILE_UPLOAD_PATH_POLICE = null;
	public static final String FILE_UPLOAD_PATH_POLICE = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/police/";
	
	
	//	�븮�� ����...
	//public static final String KCP_RETURN_URL = "http://toursales.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
}
