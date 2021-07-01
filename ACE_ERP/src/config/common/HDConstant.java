package config.common;

public class HDConstant { 
    /**
     * 각 화면의 커맨드에서 사용할 업무에 따른 상수정의
     */
    public static final String PROCESS_TYPE_INIT = "INIT";     // 초기화
    public static final String PROCESS_TYPE_SEARCH = "S";    // 조회
    public static final String PROCESS_TYPE_APPLY = "A";     // 적용
    public static final String PROCESS_TYPE_INSERET = "I";     // 등록
    public static final String PROCESS_TYPE_DELETE = "D";     // 삭제
    public static final String PROCESS_TYPE_UPDATE = "U";     // 수정
    
    public static final String PROCESS_TYPE_MODIFY = "M";     // 상세
    public static final String PROCESS_TYPE_EDIT = "E";     // 수정가능 상세 
    public static final String PROCESS_TYPE_REPLY = "R";     // 답변
    
    /**
	 * Excel 구분
	 */
	public static final String PROCESS_TYPE_EXCEL_CUSTOMER = "xsl_cust";	// 고객 엑셀
	public static final String PROCESS_TYPE_EXCEL_RESERVATION = "xsl_res"; // 예약 엑셀 

    /**
     * 각 서블릿 경로
     */
    
    // 여기가 erp 용.. :request.getContextPath() ="/services"
    // WSAD를 쓰면서부터는 이걸 고민할 이유가 사라졌다. 좋다!!!!!!!
	
	//2007-07-23 ERP 메뉴 통합
    public static final String PATH_ERP_COMMON = "/servlet/common.";
    
	//	2011-02-18 ERP 전자결재 메뉴 신설
	public static final String PATH_ERP_APPROVE = "/servlet/Approve.";


	//config 패스
	public static final String PATH_AP 		= "/servlet/config.menu.ap.";
	public static final String PATH_MY 		= "/servlet/config.menu.my.";
	public static final String PATH_SY 		= "/servlet/config.menu.sy.";
	public static final String PATH_HELP 	= "/servlet/config.menu.help.";
	public static final String PATH_COMMON 	= "/servlet/config.common.";
	  
	  
    /**
     * Message
     */
    public static final String A_MSG_CHANGE_DATA 	= "자료가 변경되었습니다. 취소또는 저장하십시오"; 		// alert 수정중 조회시, 수정중 행 추가시 
    public static final String A_MSG_SAVE_DONE 		= "자료를 저장하였습니다.";							// 저장
    public static final String A_MSG_MUST_INPUT 	= "을(를) 정확히 입력하십시오.";						// 필수 입력항목 미 입력시
    
    public static final String AS_MSG_DELETE_DONE 	= "자료를 삭제하였습니다.";							// 삭제시
    public static final String AS_MSG_SEARCH_ERR 	= "조회중 에러가 발생하였습니다.";						// 조회중 에러
    
    public static final String S_MSG_CANCEL_DONE 	= "자료 변경이 취소되었습니다.";						// 취소
    public static final String S_MSG_SAVE_DONE 		= "작업이 성공적으로 완료되었습니다.";					// 작업성공
    public static final String S_MSG_SAVE_ERR 		= "작업중 에러가 발생하였습니다";						// 작업실패
    public static final String S_MSG_SEARCH_DATA 	= "조회 중입니다. 잠시만 기다려 주십시오...";			// 조회중
    public static final String S_MSG_SEARCH_DONE 	= "조회가 완료 되었습니다.";							// 조회완료
    public static final String S_MSG_NO_DATA 		= "조회할 내용이 없습니다.";							// 데이터가 없을 경우
   
    public static final String C_MSG_ASK_DELETE 	= "삭제하시겠습니까?";									// 삭제시 
    
	/**
	 * Components 설정 3.x 버전
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
	 * Components 설정 5.x 버전 - 2014-04-07
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
	 * IE 패치 관련한 태그 
	 */
	public static final String COMMENT_START 	= "<comment id=\"__NSID__\">";
	public static final String COMMENT_END 		= "</comment><script>__WS__(__NSID__);</script>";
	
	/**
	 * 그리드 환경 설정 
	 */
	public static final String GRAD_HEAD_CONFIG = "HeadAlign=Center HeadBgColor=#b8d2ed"; // 그리드 헤더 위치 및 색
	public static final String GRAD_ERR_COLOR 	= "#FF00FF";
	public static final String GRAD_OK_COLOR 	= "#FFFFFF";
	public static final String GRID_LINK_COLOR 	= "#1579C7";
	public static final String GRID_SUM_COLOR 	= "#F0EE90";
	public static final String GRID_ITEM = "#FEFEC0" ;
	
	public static final String GRID_TOUR_COLOR 	= "#F0EE90";	//RV200I 투숙객 명단
	
	/**
	 * 파일경로
	public static final String FILE_UPLOAD_PATH_COST = "D:/MyArea/02 Project/WorkSpace/Java/HDASan/WebContent/Sales/file/photo/cust/"; // 파일 저장 경로 고객사진
	public static final String FILE_DOWNLOAD_PATH_COST = "/Sales/file/photo/cust/"; // 정보 
	 */


	//고객사진 저장 폴더
	public static final String FILE_UPLOAD_PATH_COST = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust/"; 		// 파일 저장 경로:고객사진
	//public static final String FILE_UPLOAD_PATH_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust/"; 	// 20080209 업글 전.
	public static final String FILE_DOWNLOAD_PATH_COST = "http://erp.hdasan.com/services/Sales/file/photo/cust/"; 						// 정보 
	
	//고객사진 체크 폴더 20080523 심동현
	public static final String PIC_CHECKING_PATH = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust_checking/";
	//고객사진 다운 폴더 20080523 심동현 
	public static final String PIC_DOWNLOAD_PATH = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust_download/";
	
	//	새 사진(인원) 경로 2008-10-30	
	public static final String PIC_NEW_PATH = "http://203.242.32.42/photos/cust/";
	//	새 사진(차량) 경로 2010-04-09	
	public static final String PIC_PATH_CAR = "http://203.242.32.42/photos/car/";
	
	
	
	public static final String FILE_UPLOAD_PATH_DRIVE = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/drive/"; 	// 파일 저장 경로:면허증사진
	//public static final String FILE_UPLOAD_PATH_DRIVE = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/drive/"; 	// 20080209 업글 전.
	public static final String FILE_DOWNLOAD_PATH_DRIVE = "http://erp.hdasan.com/services/Sales/file/photo/drive/"; 						// 정보 
	
	public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/"; 		// 파일 저장 경로:차량등록증사진
	//public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/"; 		// 20080209 업글 전.
	public static final String FILE_DOWNLOAD_PATH_CAR = "http://erp.hdasan.com/services/Sales/file/photo/car/"; 						// 정보 
	public static final String FILE_UPLOAD_PATH_CAR_INS = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/ins/"; 		// 파일 저장 경로:차량보험증서
		//public static final String FILE_UPLOAD_PATH_CAR = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/car/ins"; 		// 20080209 업글 전.
	public static final String FILE_DOWNLOAD_PATH_CAR_INS = "http://erp.hdasan.com/services/Sales/file/photo/car/ins/"; 						// 정보
	
	//erp excel
	//public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// 파일 저장 경로 액셀
		//	파일 저장 경로 액셀(로컬용)
		public static final String FILE_UPLOAD_PATH_EXCEL_COST = "D:/myWorks/HDAsan/WebContent/Sales/file/excel/cust/"; 	
	
	//public static final String FILE_UPLOAD_PATH_EXCEL_COST = "/QIBM/UserData/WebASE51/ASE/WAS51Exp/installedApps/erp_WAS51Exp/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/excel/cust/"; 	// 20080209 업글 전.
	public static final String FILE_DOWNLOAD_PATH_EXCEL_COST = "http://erp.hdasan.com/services/Sales/file/excel/cust/"; 					// 정보 
																   
	public static final String FILE_UPLOAD_PATH_REQ = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/req/"; 		// 파일 저장 경로 증빙사진
	public static final String FILE_DOWNLOAD_PATH_REQ = "http://erp.hdasan.com/services/Sales/file/photo/req/"; 						// 정보 
	
	public static final String FILE_UPLOAD_PATH_NOTICES = "D:/HDASan3/HDASan/WebContent/Sales/file/notices/"; 	// 파일 저장 경로 고객사진
	public static final String FILE_DOWNLOAD_PATH_NOTICES = "/Sales/file/notices/"; 					// 정보
	
	public static final String FILE_UPLOAD_PATH_CARD = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/card/sndFile/";
	public static final String FILE_DOWNLOAD_PATH_CARD = "http://erp.hdasan.com/services/Sales/file/card/sndFile/";

	public static final String FILE_UPLOAD_PATH_FILE 	= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/";	// 198서버파일 저장 경로
		//	파일 저장 경로 (로컬용)
		//public static final String FILE_UPLOAD_PATH_FILE = "D:/myWorks/HDAsan/WebContent/Sales/file/" ;
	public static final String FILE_DOWNLOAD_PATH_FILE= "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/";	// 198서버파일 저장 경로 					
	
	//	erp 기준...
	public static final String KCP_RETURN_URL_ERP = "http://erp.hdasan.com/services/Sales/help/rv005hs.jsp";	//결재 처리후 응답받은 url
	public static final String KCP_RETURN_URL_TOURSALES = "http://toursales.hdasan.com/services/Sales/help/rv005hs.jsp";	//결재 처리후 응답받은 url
	public static final String KCP_RETURN_URL_MALL ="http://erp.hdasan.com/services/Sales/help/ml005hs.jsp";	//결제 처리후 응답받은 url 쇼핑

	//경찰청 제출경로
	public static final String FILE_UPLOAD_PATH_POLICE = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/police/";
	
}
