package Ehr.edu.e.edue020.wrk;

import Ehr.edu.e.edue020.dao.EDUE020DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUE020WRK {
	/**
	 * 과정개설요청서 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_SHR_00(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE020DAO 객체 생성 후 관련 메소드 호출 */
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

        /** 과정개설요청서 SELECT하는 DAO 메소드 호출 */
		dao.EDUE020_SHR_00(p_box);

	}

	/**
	 * 과정개설요청서 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE020DAO 객체 생성 후 관련 메소드 호출 */
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

        /** 과정개설요청서 SELECT하는 DAO 메소드 호출 */
		dao.EDUE020_SHR_01(p_box);

	}

	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 과정개설요청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
    		switch (vo.getInt("TX_MODE")) {
				case 2:
					
    				/** 과정개설요청서 INSERT하는  DAO 메소드 호출 */
					dao.EDUE020_INS(vo, p_box);
//					dao.EDUE020_INS_OBJT(vo, p_box);
					break;

				case 3:

					/** 과정개설요청서UPDATE하는  DAO 메소드 호출 */
					dao.EDUE020_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}
	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_UPT_00( CBox p_box, TrBox p_tr ) throws CException {
		
		/**
		 * 과정개설요청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("STS");
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {
			
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				break;
				
			case 3:
				dao.EDUE020_UPT_00(vo, p_box);
				break;
				
			case 4:
				
				//delete
				break;
			}
		}
	}

	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 삭제 처리하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 과정개설요청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
				case 2:
					//insert
					break;

				case 3:
					//update
					break;

				case 4:

					/** 과정개설요청서 DELETE하는 DAO 메소드 호출 */
					dao.EDUE020_DEL(vo, p_box);
					break;
			}
		}
	}
	
	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE020_PROC( CBox p_box, TrBox p_tr ) throws CException {

		GauceDataSet ds = null;

		EDUE020DAO dao = new EDUE020DAO("default", p_tr);
        CBox result = dao.EDUE020_PROC(p_box);

        ds = getRtnDS(result.get("TEMP_S1")
                    ,result.get("TEMP_S2")
                    ,result.get("TEMP_S2").equals("0") ? "과정이 생성 되었습니다." : "과정이 생성이 실패 하였습니다."
                    ,""
                    ,""
                    ,""
        );

        //rtn
        p_tr.setOutDataSet("dsRESULT", ds);
	}
	/**
     * 결과 처리에 사용되는 DS를 반환 시킴
     * @param pro_sts
     * @param rtn_cd
     * @param rtn_msg
     * @param wrk_no1
     * @param wrk_no2
     * @param wrk_no3
     * @return
     */
    private GauceDataSet getRtnDS(String pro_sts
            ,String rtn_cd
            ,String rtn_msg
            ,String wrk_no1
            ,String wrk_no2
            ,String wrk_no3) {
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow row = null;

        GauceDataColumn[] cols = {
                new GauceDataColumn("PRO_STS",  ColumnProp.COLUMN_TYPE_STRING)
               ,new GauceDataColumn("RTN_CD",   ColumnProp.COLUMN_TYPE_STRING)
               ,new GauceDataColumn("RTN_MSG",  ColumnProp.COLUMN_TYPE_STRING)
               ,new GauceDataColumn("WRK_NO1",  ColumnProp.COLUMN_TYPE_STRING)
               ,new GauceDataColumn("WRK_NO2",  ColumnProp.COLUMN_TYPE_STRING)
               ,new GauceDataColumn("WRK_NO3",  ColumnProp.COLUMN_TYPE_STRING)
        };
        ds.addDataColumns(cols);

        row = ds.newDataRow();
        row.addColumnValue(pro_sts);
        row.addColumnValue(rtn_cd);
        row.addColumnValue(rtn_msg);
        row.addColumnValue(wrk_no1);
        row.addColumnValue(wrk_no2);
        row.addColumnValue(wrk_no3);
        ds.addDataRow(row);

        return ds;
    }
}
