package omsm.common;

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
    
	/*^^
	//pms �н�
	public static final String PATH_CT = "/servlet/pms.menu.ct.";
	public static final String PATH_PC = "/servlet/pms.menu.pc.";
	public static final String PATH_PU = "/servlet/pms.menu.pu.";
	public static final String PATH_SI = "/servlet/pms.menu.si.";
	public static final String PATH_CO = "/servlet/pms.menu.co.";
	public static final String PATH_SY = "/servlet/pms.menu.sy.";
	public static final String PATH_HELP = "/servlet/pms.menu.help.";
	public static final String PATH_COMMON = "/servlet/pms.common.";
	public static final String PATH_SALES_HELP = "/servlet/sales.menu.help.";
	public static final String PATH_ACCOUNT ="/servlet/Account.";
	//2011-02-18 ERP ���ڰ��� �޴� �ż�
    //public static final String PATH_ERP_APPROVE = "/servlet/Approve.";
    public static final String PATH_SI = "/servlet/pms.menu.si.";
    */
	
	public static final String PATH_OMSM = "/servlet/omsm.";
	public static final String PATH_OMSM_AN = "/servlet/omsm.an.";
	public static final String PATH_OMSM_CO = "/servlet/omsm.co.";
	public static final String PATH_OMSM_OR = "/servlet/omsm.or.";
	public static final String PATH_OMSM_POP = "/servlet/omsm.popup.";
	public static final String PATH_OMSM_CA = "/servlet/omsm.ca.";
	public static final String PATH_OMSM_AL = "/servlet/omsm.al.";
	
	/**
	 * Message
	 */
	/*^^
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
    
    */
	/**
	 * Components 
	 */
	public static final String CT_GRID_CLSID 			= "'clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49'";
	public static final String CT_EMEDIT_CLSID		= "'clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'";
	public static final String CT_TREEVIEW_CLSID		= "'clsid:4401B994-DD33-11D2-B539-006097ADB678' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/toinbtree.cab#version=1,1,1,40'";
	public static final String CT_LUXECOMBO_CLSID		= "'clsid:60109D65-70C0-425C-B3A4-4CB001513C69' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/LuxeCombo.cab#version=1,1,1,63'";
	public static final String CT_MENU_CLSID			= "'clsid:7A54CBF0-2CB4-11D4-973E-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbMenu.cab#version=1,1,1,25'";
	public static final String CT_TEXTAREA_CLSID		= "'clsid:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTextArea.cab#version=1,1,1,23'";
	public static final String CT_RADIO_CLSID			= "'clsid:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbRadio.cab#version=1,1,1,24'";
	public static final String CT_TAB_CLSID			= "'clsid:ED382953-E907-11D3-B694-006097AD7252' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTab.cab#version=1,1,1,20'";
	public static final String CT_REPORT_CLSID		= "'clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/toinbrep.cab#version=1,1,1,82'";
	public static final String CT_DATASET_CLSID		= "'clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49'";
	public static final String CT_TR_CLSID			= "'clsid:0A2233AD-E771-11D2-973D-00104B15E56F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbTR.cab#version=1,1,1,49'";
	public static final String CT_IMG_DATASET_CLSID	= "'clsid:BCB3A52D-F8E7-11D3-973E-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbImgData.cab#version=1,1,1,20'";
	public static final String CT_INPUT_FILE_CLSID	= "'clsid:69F1348F-3EBE-11D3-973D-0060979E2A03' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbIFile.cab#version=1,1,1,17'";
	public static final String CT_BINDER_CLASSID 		= "'clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbBind.cab#version=1,1,1,18'";
	
	
	public static final String MXCT_GRID_CLSID        ="'clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B'";
	public static final String MXCT_MGRID_CLSID       ="'clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08'";
	public static final String MXCT_EMEDIT_CLSID      ="'clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F'"; 
	public static final String MXCT_TREEVIEW_CLSID    ="'clsid:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2'";
	public static final String MXCT_LUXECOMBO_CLSID   ="'clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197'"; 
	public static final String MXCT_MENU_CLSID        ="'clsid:216FC5D2-962D-4DD6-A000-02754CF91231'";
	public static final String MXCT_TEXTAREA_CLSID    ="'clsid:2F5DF8D9-F63C-460E-B5CB-399E816B0274'";
	public static final String MXCT_RADIO_CLSID       ="'clsid:B22DC058-80A2-438F-A64D-08B3B04AD7E0'";
	public static final String MXCT_TAB_CLSID         ="'clsid:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C'";
	public static final String MXCT_REPORT_CLSID      ="'clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089'"; 
	public static final String MXCT_DATASET_CLSID     ="'clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB'"; 
	public static final String MXCT_TR_CLSID          ="'clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5'"; 
	public static final String MXCT_IMGDATASET_CLSID  ="'clsid:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A'"; 
	public static final String MXCT_INPUTFILE_CLSID   ="'clsid:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE'";
	public static final String MXCT_BIND_CLSID        ="'clsid:4A35BB2C-B831-4199-A486-FEA332D085D9'";
	public static final String MXCT_POTENTIAL_CLSID   ="'clsid:1C18220D-EC23-48C8-B35E-857ADE9D1465'";
	public static final String MXCT_LOCALDB_CLSID     ="'clsid:2BFF9B97-8758-4225-AD74-34BBF7AECC68'";
	public static final String MXCT_XCHART_CLSID      ="'clsid:2A99B1B3-E263-4A00-A167-C1B967716DE2'";
	public static final String MXCT_GAUGECHART_CLSID  ="'clsid:B347FE88-0702-473B-9775-CA4393BCFEEE'"; 

	
	/*
	Grid            EA8B6EE6-3DD8-4534-B4BB-27148CF0042B
	Mgrid		    8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08
	EMEdit		    4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
	Treeview	    6DD1CE9F-1722-46F0-AF93-B2BC58383CD2
	LuxeCombo	    D8BCC087-4710-427D-B2E4-A4B93B6EA197
	Menu		    216FC5D2-962D-4DD6-A000-02754CF91231
	TextArea	    2F5DF8D9-F63C-460E-B5CB-399E816B0274
	Radio		    B22DC058-80A2-438F-A64D-08B3B04AD7E0
	Tab		    6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
	Report		    CC26E2A9-760B-4EA6-8DDF-DB423FD24089
	DataSet		    2506B38B-0FF7-4249-BA3E-8BC1DC399FBB
	Tr		    78E24950-4295-43D8-9B1A-1F41CD7130E5
	ImgDataSet	    2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A
	InputFile	    C722848E-C7EE-4DC6-947E-C2CD49BBA9DE
	Bind		    4A35BB2C-B831-4199-A486-FEA332D085D9
	Potential	    1C18220D-EC23-48C8-B35E-857ADE9D1465
	LocalDB		    2BFF9B97-8758-4225-AD74-34BBF7AECC68
	Xchart		    2A99B1B3-E263-4A00-A167-C1B967716DE2
	ActiveUpdate4.0	                                        
	GaugeChart	    B347FE88-0702-473B-9775-CA4393BCFEEE
    */
    	
	
	/**
	 * IE ��ġ ������ �±� 
	 */
	public static final String COMMENT_START 	= "<comment id=\"__NSID__\">";
	public static final String COMMENT_END 	= "</comment><script>__WS__(__NSID__);</script>";
	
	/**
	 * �׸��� ȯ�� ���� 
	 */
	public static final String GRAD_HEAD_CONFIG = "HeadAlign=Center HeadBgColor=#b8d2ed"; // �׸��� ��� ��ġ �� ��
	
		
	public static final String GRAD_ERR_COLOR 	= "#FF00FF";
	public static final String GRAD_OK_COLOR 	    = "#FFFFFF";
	public static final String GRID_LINK_COLOR 	= "#1579C7";
	public static final String GRID_SUM_COLOR 	= "#F0EE90";
	public static final String GRID_ITEM          = "#FEFEC0";
	
	
	/**
	 * ���ϰ��
	public static final String FILE_UPLOAD_PATH_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/photo/cust/"; // ���� ���� ��� ������
	public static final String FILE_DOWNLOAD_PATH_COST = "/Sales/file/photo/cust/"; // ���� 
	
	 */
	
	//����
	//public static final String FILE_UPLOAD_PATH_FILE = "C:"; // ����
	
	//����
	public static final String FILE_UPLOAD_PATH_FILE   = "/asanwas/account/"; // ����
	public static final String FILE_DOWNLOAD_PATH_FILE = "/asanwas/account/";
	
	
	
	//public static final String FILE_UPLOAD_PATH_FILE 	= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/";	// 198�������� ���� ���
		//	���� ���� ��� (���ÿ�)
		//public static final String FILE_UPLOAD_PATH_FILE = "D:/myWorks/HDAsan/WebContent/Pms/file/" ;
		//public static final String FILE_DOWNLOAD_PATH_FILE= "D:/myWorks/HDAsan/WebContent/Pms/file/" ;
	//public static final String FILE_DOWNLOAD_PATH_FILE= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/";	// 198�������� ���� ��� 					
	
	
}
