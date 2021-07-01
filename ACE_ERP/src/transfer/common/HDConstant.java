package transfer.common;

public class HDConstant { 
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
    
    // ���Ⱑ erp ��.. :request.getContextPath() ="/services"
    // WSAD�� ���鼭���ʹ� �̰� ����� ������ �������. ����!!!!!!!
	
	//2007-07-23 ERP �޴� ����
    public static final String PATH_ERP_COMMON = "/servlet/common.";
    
	//	2011-02-18 ERP ���ڰ��� �޴� �ż�
	public static final String PATH_ERP_APPROVE = "/servlet/Approve.";



	//���� ���� purch path
    public static final String PATH_HELP = "/servlet/purch.menu.help.";
    public static final String PATH_SAMPLE = "/servlet/purch.sample.";
    public static final String PATH_COMMON = "/servlet/purch.common.";
	public static final String PATH_PURCH = "/servlet/purch.";
	public static final String PATH_TRANSFER = "/servlet/transfer.";


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


	//������ ���� ����
	public static final String FILE_UPLOAD_PATH_COST = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust/"; 		// ���� ���� ���:������
	//public static final String FILE_UPLOAD_PATH_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust/"; 	// 20080209 ���� ��.
	public static final String FILE_DOWNLOAD_PATH_COST = "http://erp.hdasan.com/services/Sales/file/photo/cust/"; 						// ���� 
	
	//������ üũ ���� 20080523 �ɵ���
	public static final String PIC_CHECKING_PATH = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust_checking/";
	//������ �ٿ� ���� 20080523 �ɵ��� 
	public static final String PIC_DOWNLOAD_PATH = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust_download/";
	
	//	�� ����(�ο�) ��� 2008-10-30	
	public static final String PIC_NEW_PATH = "http://203.242.32.42/photos/cust/";
	//	�� ����(����) ��� 2010-04-09	
	public static final String PIC_PATH_CAR = "http://203.242.32.42/photos/car/";
	
	
	
	public static final String FILE_UPLOAD_PATH_DRIVE = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/drive/"; 	// ���� ���� ���:����������
	//public static final String FILE_UPLOAD_PATH_DRIVE = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/drive/"; 	// 20080209 ���� ��.
	public static final String FILE_DOWNLOAD_PATH_DRIVE = "http://erp.hdasan.com/services/Sales/file/photo/drive/"; 						// ���� 
	
	public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/"; 		// ���� ���� ���:�������������
	//public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/"; 		// 20080209 ���� ��.
	public static final String FILE_DOWNLOAD_PATH_CAR = "http://erp.hdasan.com/services/Sales/file/photo/car/"; 						// ���� 
	public static final String FILE_UPLOAD_PATH_CAR_INS = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/ins/"; 		// ���� ���� ���:������������
		//public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/ins"; 		// 20080209 ���� ��.
	public static final String FILE_DOWNLOAD_PATH_CAR_INS = "http://erp.hdasan.com/services/Sales/file/photo/car/ins/"; 						// ����
	
	//erp excel
	public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// ���� ���� ��� �׼�
		//	���� ���� ��� �׼�(���ÿ�)
		//public static final String FILE_UPLOAD_PATH_EXCEL_COST = "D:/myWorks/HDAsan/WebContent/Sales/file/excel/cust/"; 	
	
	//public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// 20080209 ���� ��.
	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "http://erp.hdasan.com/services/Sales/file/excel/cust/"; 					// ���� 
																   
	public static final String FILE_UPLOAD_PATH_REQ = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/req/"; 		// ���� ���� ��� ��������
	public static final String FILE_DOWNLOAD_PATH_REQ = "http://erp.hdasan.com/services/Sales/file/photo/req/"; 						// ���� 
	
	public static final String FILE_UPLOAD_PATH_NOTICES = "D:/HDASan3/HDASan/WebContent/Sales/file/notices/"; 	// ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_NOTICES = "/Sales/file/notices/"; 					// ����
	
	public static final String FILE_UPLOAD_PATH_CARD = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/card/sndFile/";
	public static final String FILE_DOWNLOAD_PATH_CARD = "http://erp.hdasan.com/services/Sales/file/card/sndFile/";

	public static final String FILE_UPLOAD_PATH_FILE 	= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/";	// 198�������� ���� ���
		//	���� ���� ��� (���ÿ�)
		//public static final String FILE_UPLOAD_PATH_FILE = "D:/myWorks/HDAsan/WebContent/Sales/file/" ;
	public static final String FILE_DOWNLOAD_PATH_FILE= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/";	// 198�������� ���� ��� 					
	
	
	
	
	
	
	
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
	public static final String KCP_RETURN_URL_ERP = "http://erp.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
	public static final String KCP_RETURN_URL_TOURSALES = "http://toursales.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
	public static final String FILE_UPLOAD_PATH_POLICE = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/police/";
	
}
