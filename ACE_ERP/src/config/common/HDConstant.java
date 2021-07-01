package config.common;

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


	//config �н�
	public static final String PATH_AP 		= "/servlet/config.menu.ap.";
	public static final String PATH_MY 		= "/servlet/config.menu.my.";
	public static final String PATH_SY 		= "/servlet/config.menu.sy.";
	public static final String PATH_HELP 	= "/servlet/config.menu.help.";
	public static final String PATH_COMMON 	= "/servlet/config.common.";
	  
	  
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
	 * Components ���� 3.x ����
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
	 * Components ���� 5.x ���� - 2014-04-07
	 */
	public static final String MxGridU_CLSID			= "'clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B' codebase='http://ace.hdasan.com/Common/cabfiles/MxGridU.cab#version=2,0,1,361'";
	public static final String MxGridU_CLSID_S			= "'clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B' ";
	public static final String MxMGridU_CLSID			= "'clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08' codebase='http://ace.hdasan.com/Common/cabfiles/MxMGridU.cab#version=2,0,1,77'";
	public static final String MxMGridU_CLSID_S			= "'clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08' ";
	public static final String MxMaskEditU_CLSID		= "'clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F' codebase='http://ace.hdasan.com/Common/cabfiles/MxMaskEditU.cab#version=2,0,1,78'";
	public static final String MxMaskEditU_CLSID_S		= "'clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F' ";
	public static final String MxTreeU_CLSID			= "'clsid:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2' codebase='http://ace.hdasan.com/Common/cabfiles/MxTreeU.cab#version=2,0,1,34'";
	public static final String MxTreeU_CLSID_S			= "'clsid:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2' ";
	public static final String MxComboU_CLSID			= "'clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197' codebase='http://ace.hdasan.com/Common/cabfiles/MxComboU.cab#version=2,0,1,56'";
	public static final String MxComboU_CLSID_S			= "'clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197' ";
	public static final String MxMenuU_CLSID			= "'clsid:216FC5D2-962D-4DD6-A000-02754CF91231' codebase='http://ace.hdasan.com/Common/cabfiles/MxMenuU.cab#version=2,0,1,12'";
	public static final String MxMenuU_CLSID_S			= "'clsid:216FC5D2-962D-4DD6-A000-02754CF91231' ";
	public static final String MxTextAreaU_CLSID		= "'clsid:2F5DF8D9-F63C-460E-B5CB-399E816B0274' codebase='http://ace.hdasan.com/Common/cabfiles/MxTextAreaU.cab#version=2,0,1,31'";
	public static final String MxTextAreaU_CLSID_S		= "'clsid:2F5DF8D9-F63C-460E-B5CB-399E816B0274' ";
	public static final String MxRadioU_CLSID			= "'clsid:B22DC058-80A2-438F-A64D-08B3B04AD7E0' codebase='http://ace.hdasan.com/Common/cabfiles/MxRadioU.cab#version=2,0,1,21'";
	public static final String MxRadioU_CLSID_S			= "'clsid:B22DC058-80A2-438F-A64D-08B3B04AD7E0' ";
	public static final String MxTabU_CLSID				= "'clsid:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C' codebase='http://ace.hdasan.com/Common/cabfiles/MxTabU.cab#version=2,0,1,10'";
	public static final String MxTabU_CLSID_S			= "'clsid:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C' ";
	public static final String MxReportU_CLSID			= "'clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089' codebase='http://ace.hdasan.com/Common/cabfiles/MxReportU.cab#version=2,0,1,73'";
	public static final String MxReportU_CLSID_S		= "'clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089' ";
	public static final String MxDataSetU_CLSID			= "'clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB' codebase='http://ace.hdasan.com/Common/cabfiles/MxDataSetU.cab#version=2,0,1,95'";
	public static final String MxDataSetU_CLSID_S		= "'clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB' ";
	public static final String MxLogicalTRU_CLSID		= "'clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5' codebase='http://ace.hdasan.com/Common/cabfiles/MxLogicalTRU.cab#version=2,0,1,59'";
	public static final String MxLogicalTRU_CLSID_S		= "'clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5' ";
	public static final String MxImageSetU_CLSID		= "'clsid:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A' codebase='http://ace.hdasan.com/Common/cabfiles/MxImageSetU.cab#version=2,0,1,10'";
	public static final String MxImageSetU_CLSID_S		= "'clsid:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A' ";
	public static final String MxFileControlU_CLSID		= "'clsid:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE' codebase='http://ace.hdasan.com/Common/cabfiles/MxFileControlU.cab#version=2,0,1,14'";
	public static final String MxFileControlU_CLSID_S	= "'clsid:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE' ";
	public static final String MxBinderU_CLASSID 		= "'clsid:4A35BB2C-B831-4199-A486-FEA332D085D9' codebase='http://ace.hdasan.com/Common/cabfiles/MxBinderU.cab#version=2,0,1,12'";
	public static final String MxBinderU_CLASSID_S 		= "'clsid:4A35BB2C-B831-4199-A486-FEA332D085D9' ";
	public static final String Potential_CLSID			= "'clsid:1C18220D-EC23-48C8-B35E-857ADE9D1465' codebase='http://ace.hdasan.com/Common/cabfiles/Potential.cab#version=1,0,45,62'";
	public static final String Potential_CLSID_S		= "'clsid:1C18220D-EC23-48C8-B35E-857ADE9D1465' ";
	public static final String MxLocalDBU_CLSID			= "'clsid:2BFF9B97-8758-4225-AD74-34BBF7AECC68' codebase='http://ace.hdasan.com/Common/cabfiles/MxLocalDBU.cab#version=2,0,1,1'";
	public static final String MxLocalDBU_CLSID_S		= "'clsid:2BFF9B97-8758-4225-AD74-34BBF7AECC68' ";
		
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
	//public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// ���� ���� ��� �׼�
		//	���� ���� ��� �׼�(���ÿ�)
		public static final String FILE_UPLOAD_PATH_EXCEL_COST = "D:/myWorks/HDAsan/WebContent/Sales/file/excel/cust/"; 	
	
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
	
	//	erp ����...
	public static final String KCP_RETURN_URL_ERP = "http://erp.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
	public static final String KCP_RETURN_URL_TOURSALES = "http://toursales.hdasan.com/services/Sales/help/rv005hs.jsp";	//���� ó���� ������� url
	public static final String KCP_RETURN_URL_MALL ="http://erp.hdasan.com/services/Sales/help/ml005hs.jsp";	//���� ó���� ������� url ����

	//����û ������
	public static final String FILE_UPLOAD_PATH_POLICE = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/police/";
	
}
