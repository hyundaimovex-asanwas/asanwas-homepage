package Ehr.vlu.o.vluo100.wrk;

import java.util.Date;

import Ehr.vlu.o.vluo020.dao.VLUO020DAO;
import Ehr.vlu.o.vluo100.dao.VLUO100DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;
import Ehr.eis.t.eist020.dao.EIST020DAO;

import java.io.File;
import java.io.IOException;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class VLUO100WRK {

    /**
     * 목표설정 (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정/세부추진계획 (조회) DAO CLASS 메서드 호출 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		//p_box.set("GOAL_NO", "1");
		
		dao.VLUO100_SHR(p_box);

	}

	
    public void VLUO100_SHR_22(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 개인별평가일정 조회 DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        
        dao.VLUO100_SHR_22(p_box);

    }
	
    /**
     * 목표설정 (출력용) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_SHR_PRT(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정/세부추진계획 (조회) DAO CLASS 메서드 호출 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
		dao.VLUO100_SHR_PRT(p_box);

	}	
	
	/**
     * 개인별평가일정  조회  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_00(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 개인별평가일정 조회 DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_00(p_box);

    }

    /**
     * 평가자 조회  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 평가자 조회 DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        GauceDataSet ds = new GauceDataSet();

        ds = dao.VLUO100_SHR_01(p_box);

        // 평가 결재테이블에 평가자 리스트가 없을 시 평가대상리스트에서 가져옴
        if(ds.getDataRowCnt() < 1) {
        	ds = dao.VLUO100_SHR_02(p_box);
        }

		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_EVL_APPROVAL", ds);

    }

    /**
     * 목표순번 최대값  (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_01_OLD(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정(조회) DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_01_OLD(p_box);

    }

    /**
     * 목표승인여부  (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_02(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정(조회) DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_02(p_box);

    }

    /**
     * 목표입력 기간 여부  (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_03(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표입력 기간 여부 (조회) DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_03(p_box);

    }

    /**
     * 평가대상자  (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_04(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 평가대상자  (조회) DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_04(p_box);

    }

    /**
     * 평가일정 (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_SHR_YMD(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 평가일정  (조회) DAO CLASS 메서드 호출 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_YMD(p_box);

    }

    /**
     * 목표설정 (입력,수정,삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// 목표설정 전체 삭제 후 저장
		try {
			dao.VLUO100_DEL_01(p_box, voList.get(0));
		}catch(Exception ex) {
			
		}

		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:
		 	    	//Log.main.println(vo);
                    break;
			    case 2:
			    	//Log.main.println(vo);
			    	this.VLUO100_INS(vo, p_box, p_tr);
			    	break;
			    case 3:
			        //Log.main.println(vo);
			    	this.VLUO100_INS(vo, p_box, p_tr);
				    //dao.VLUO100_UPT(p_box, vo);
				    break;
			    case 4:
				    //Log.main.println(vo);
			    	//dao.VLUO100_DEL_01(p_box, voList.get(0));
                    break;
			}
		}
	}

	
	public void VLUO100_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_INS(p_box, vo);

	}		
	

	
	 /**
     * 엑셀파일 생성 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_EXL(CBox p_box, TrBox p_tr) throws CException, WriteException, Exception {

		/** DAO Class 객체 생성 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		WritableWorkbook workbook = null;
		WritableSheet sheet = null;

		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:
		 	    	Log.main.println(vo);
                    break;
			    case 2:
			    	Log.main.println(vo);

			    	workbook = Workbook.createWorkbook(new File("C:\\teest.xls"));
					workbook.createSheet("Sheet", 0);                    //지정한 워크북에 싯트를 만듭니다. "Sheet" 가 싯트명이 됩니다.
					sheet = workbook.getSheet(0);                         //시트를 가져옵니다.

					WritableCellFormat cellFormat = new WritableCellFormat();    //셀의 스타일을 지정하기 위한 부분입니다.
					cellFormat.setBorder(Border.ALL , BorderLineStyle.THIN);      //셀의 스타일을 지정합니다. 테두리에 라인그리는거에요

					//System.out.println("아짱나2");
					 // 빙글빙글 돌리면서 엑셀에 데이터를 작성합니다.
					 Label label = new jxl.write.Label(i , 1 , vo.get("KPI").toString() , cellFormat);
					 sheet.addCell(label);

					workbook.write();

			    	break;
			    case 3:
			        Log.main.println(vo);
				    break;
			    case 4:
				    Log.main.println(vo);
                    break;
			}
		}

		/*try {


			workbook = Workbook.createWorkbook(new File("C:\test.xls"));
			workbook.createSheet("Sheet", 0);                    //지정한 워크북에 싯트를 만듭니다. "Sheet" 가 싯트명이 됩니다.
			sheet = workbook.getSheet(0);                         //시트를 가져옵니다.

			WritableCellFormat cellFormat = new WritableCellFormat();    //셀의 스타일을 지정하기 위한 부분입니다.
			cellFormat.setBorder(Border.ALL , BorderLineStyle.THIN);      //셀의 스타일을 지정합니다. 테두리에 라인그리는거에요

			System.out.println("아짱나2");
			for (int i=0; i<voList.size(); i++) {
				GauceValueObject vo = voList.get(i);

				 // 빙글빙글 돌리면서 엑셀에 데이터를 작성합니다.
				 Label label = new jxl.write.Label(i , 1 , vo.get("KPI") , cellFormat);
				 sheet.addCell(label);
			}

			workbook.write();

		} catch(Exception e) {
				e.printStackTrace();
				throw e;
		} finally {
			try {
			if(workbook != null) workbook.close();
			}catch (IOException e) {

			}

		}*/
	}

	  /**
     * 상신처리 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
			    case 2:
			    		
			    	// 
			    	this.VLUO100_SAV_01(p_box, vo, p_tr);
			    	//dao.VLUO100_INS_01(p_box, vo);
			    	break;
			    case 3:

				    break;
			    case 4:

                    break;
			}
		}

		if(voList.size() > 0) {
	    	// 목표설정 승인상태 업데이트
            //p_box.set("STATUS"		, "R");		//상태(R:미결,Y:결재,N:부결)
            //p_box.set("EVL_YYYY"	, voList.get(0).get("EVL_YYYY"));	//해당년도
            //p_box.set("ENO_NO"		, voList.get(0).get("ENO_NO"));		//피평가자사번

	    	//dao.VLUO100_SAV_01(p_box, p_tr);
		}
		
	}

	public void VLUO100_SAV_01(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_01(p_box, vo);

	}		

	public void VLUO100_SAV_011(CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			

		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_011(p_box);

	}		
	
    /**
     * 결재 또는 부결 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO100_SAV_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
                    
			    case 2:

			    	this.VLUO100_SAV_02(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	this.VLUO100_SAV_02(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}	
	
	public void VLUO100_SAV_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_02(p_box, vo);

	}		
	
	public void VLUO100_UPT_02(CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_UPT_02(p_box);

	}		
	
	public void VLUO100_UPT_03(CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_UPT_03(p_box);

	}		
	
    /**
     * 목표설정 (삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO100_DEL(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성 * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        for (int i=0; i<voList.size(); i++) {
            GauceValueObject vo = voList.get(i);
            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            switch(vo.getInt("TX_MODE")) {
            case 1:
                Log.main.println(vo);
                break;
            case 2:
                Log.main.println(vo);
                break;
            case 3:
                Log.main.println(vo);
                break;
            case 4:
                Log.main.println(vo);
                dao.VLUO100_DEL(p_box, vo);
                break;
            }
        }

    }
}
