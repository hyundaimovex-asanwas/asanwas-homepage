package Ehr.eis.t.eist010.wrk;

import Ehr.eis.t.eist010.dao.EIST010DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST010WRK {
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST010_SHR(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        
        GauceValueObject vo = null;
        
		GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

		ds.addDataColumn(new GauceDataColumn("PJT_CD", GauceDataColumn.TB_STRING,  8, 0, GauceDataColumn.TB_KEY));
        ds.addDataColumn(new GauceDataColumn("PJT_NM", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DAY_01", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_02", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_03", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_04", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_05", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_06", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_07", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_08", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_09", GauceDataColumn.TB_NUMBER ));
        ds.addDataColumn(new GauceDataColumn("DAY_10", GauceDataColumn.TB_NUMBER ));
        ds.addDataColumn(new GauceDataColumn("DAY_11", GauceDataColumn.TB_NUMBER ));        
		ds.addDataColumn(new GauceDataColumn("DAY_12", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_13", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_14", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_15", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_16", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_17", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_18", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_19", GauceDataColumn.TB_NUMBER ));		
        ds.addDataColumn(new GauceDataColumn("DAY_20", GauceDataColumn.TB_NUMBER ));
        ds.addDataColumn(new GauceDataColumn("DAY_21", GauceDataColumn.TB_NUMBER ));        
		ds.addDataColumn(new GauceDataColumn("DAY_22", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_23", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_24", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_25", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_26", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_27", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_28", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_29", GauceDataColumn.TB_NUMBER ));			
		ds.addDataColumn(new GauceDataColumn("DAY_30", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DAY_31", GauceDataColumn.TB_NUMBER ));		
        ds.addDataColumn(new GauceDataColumn("YOIL_01", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_02", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_03", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_04", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_05", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_06", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_07", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_08", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_09", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("YOIL_10", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("YOIL_11", GauceDataColumn.TB_STRING ));        
		ds.addDataColumn(new GauceDataColumn("YOIL_12", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_13", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_14", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_15", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_16", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_17", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_18", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_19", GauceDataColumn.TB_STRING ));		
        ds.addDataColumn(new GauceDataColumn("YOIL_20", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("YOIL_21", GauceDataColumn.TB_STRING ));        
		ds.addDataColumn(new GauceDataColumn("YOIL_22", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_23", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_24", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_25", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_26", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_27", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_28", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_29", GauceDataColumn.TB_STRING ));			
		ds.addDataColumn(new GauceDataColumn("YOIL_30", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("YOIL_31", GauceDataColumn.TB_STRING ));	
		ds.addDataColumn(new GauceDataColumn("STATUS", GauceDataColumn.TB_STRING ));	
		ds.addDataColumn(new GauceDataColumn("TEAM_CD", GauceDataColumn.TB_STRING ));
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);
		
		//1.해당팀에 어떤 프로젝트가 등록되어 있는지 Check
		GauceDataSet dsPJT = dao.EIST010_PJT(p_box);


		//2. 등록되어 있는 PJT 만큼 for문을 돌린다.
		for(int i = 1; i <= dsPJT.getDataRowCnt(); i++){		
		
			String SEQ = GauceUtils.nameValue(dsPJT, i, "SEQ");	
			
			dr = new GauceDataRow(ds.getDataColCnt());	

			voList = GauceUtils.getGauceValueObject(this.EIST010_SHR_01(p_box,  SEQ, p_tr));

			vo = voList.get(0);	
			
    		dr.setString( 0, vo.getString("PJT_CD"));
    		dr.setString( 1, vo.getString("PJT_NM"));
    		dr.setInt( 2, vo.getInt("DAY_01"));
            dr.setInt( 3, vo.getInt("DAY_02"));
            dr.setInt( 4, vo.getInt("DAY_03"));
            dr.setInt( 5, vo.getInt("DAY_04"));
            dr.setInt( 6, vo.getInt("DAY_05"));
            dr.setInt( 7, vo.getInt("DAY_06"));
            dr.setInt( 8, vo.getInt("DAY_07"));
    		dr.setInt( 9, vo.getInt("DAY_08"));
            dr.setInt(10, vo.getInt("DAY_09"));
            dr.setInt(11, vo.getInt("DAY_10"));
            dr.setInt(12, vo.getInt("DAY_11"));
            dr.setInt(13, vo.getInt("DAY_12"));
            dr.setInt(14, vo.getInt("DAY_13"));
            dr.setInt(15, vo.getInt("DAY_14"));
    		dr.setInt(16, vo.getInt("DAY_15"));
            dr.setInt(17, vo.getInt("DAY_16"));
            dr.setInt(18, vo.getInt("DAY_17"));
            dr.setInt(19, vo.getInt("DAY_18"));
            dr.setInt(20, vo.getInt("DAY_19"));
            dr.setInt(21, vo.getInt("DAY_20"));
            dr.setInt(22, vo.getInt("DAY_21"));            
            dr.setInt(23, vo.getInt("DAY_22"));
            dr.setInt(24, vo.getInt("DAY_23"));
            dr.setInt(25, vo.getInt("DAY_24"));
            dr.setInt(26, vo.getInt("DAY_25"));
            dr.setInt(27, vo.getInt("DAY_26"));
            dr.setInt(28, vo.getInt("DAY_27"));             
            dr.setInt(29, vo.getInt("DAY_28"));
            dr.setInt(30, vo.getInt("DAY_29"));
            dr.setInt(31, vo.getInt("DAY_30"));
            dr.setInt(32, vo.getInt("DAY_31"));             
	            
    	    dr.setString(33, vo.getString("YOIL_01"));
            dr.setString(34, vo.getString("YOIL_02"));
            dr.setString(35, vo.getString("YOIL_03"));
            dr.setString(36, vo.getString("YOIL_04"));
            dr.setString(37, vo.getString("YOIL_05"));
            dr.setString(38, vo.getString("YOIL_06"));
            dr.setString(39, vo.getString("YOIL_07"));
    	    dr.setString(40, vo.getString("YOIL_08"));
            dr.setString(41, vo.getString("YOIL_09"));
            dr.setString(42, vo.getString("YOIL_10"));
            dr.setString(43, vo.getString("YOIL_11"));
            dr.setString(44, vo.getString("YOIL_12"));
            dr.setString(45, vo.getString("YOIL_13"));
            dr.setString(46, vo.getString("YOIL_14"));
    	    dr.setString(47, vo.getString("YOIL_15"));
            dr.setString(48, vo.getString("YOIL_16"));
            dr.setString(49, vo.getString("YOIL_17"));
            dr.setString(50, vo.getString("YOIL_18"));
            dr.setString(51, vo.getString("YOIL_19"));
            dr.setString(52, vo.getString("YOIL_20"));
            dr.setString(53, vo.getString("YOIL_21"));
            dr.setString(54, vo.getString("YOIL_22"));
            dr.setString(55, vo.getString("YOIL_23"));
            dr.setString(56, vo.getString("YOIL_24"));
            dr.setString(57, vo.getString("YOIL_25"));
            dr.setString(58, vo.getString("YOIL_26"));
            dr.setString(59, vo.getString("YOIL_27"));
            dr.setString(60, vo.getString("YOIL_28"));
            dr.setString(61, vo.getString("YOIL_29"));
            dr.setString(62, vo.getString("YOIL_30"));
            dr.setString(63, vo.getString("YOIL_31"));            
            dr.setString(64, vo.getString("STATUS")); 
            dr.setString(65, vo.getString("TEAM_CD")); 
            
            ds.addDataRow(dr);			

		}		
		
		p_tr.setOutDataSet("dsT_TS_TIMESHEET", ds);
		
	}
	
	
	public GauceDataSet EIST010_SHR_01(CBox p_box, String SEQ, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);

		return dao.EIST010_SHR(p_box, SEQ);

	}		
	

	
	
	/**
	 * 저장 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST010DAO dao = new EIST010DAO("default", p_tr);
		
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
					// 입력하기 위한 DAO메소드 호출
					//dao.EIST010_INS(vo, p_box);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					this.EIST010_DEL(vo, p_box, p_tr);	
					
					for (int j=1; j<32; j++) {

						this.EIST010_INS(vo, p_box, p_tr, j);
					
					}
					
					break;
				
			}
		}
	}	
	
	public void EIST010_INS(GauceValueObject vo, CBox p_box, TrBox p_tr, int dd) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);

		dao.EIST010_INS(vo, p_box, dd);

	}			
	
	
	
	/**
	 * 상신 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST010_UPT(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST010DAO dao = new EIST010DAO("default", p_tr);
		
		//System.out.println(p_box);
		//System.out.println(p_tr);		
		
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
					// 입력하기 위한 DAO메소드 호출
					//dao.EIST010_INS(vo, p_box);
					this.EIST010_UPT2(vo, p_box, p_tr);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					//this.EIST010_DEL(vo, p_box, p_tr);	
					//this.EIST010_UPT2(vo, p_box, p_tr);

					
					break;
				
			}
		}
	}	
	
	public void EIST010_UPT2(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);

		dao.EIST010_UPT2(vo, p_box);

	}		
	
	
	
	/**
	 * 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST010_UPT_APP(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST010DAO dao = new EIST010DAO("default", p_tr);
		
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
					// 입력하기 위한 DAO메소드 호출
					//dao.EIST010_INS(vo, p_box);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					//this.EIST010_DEL(vo, p_box, p_tr);	
					
					for (int j=1; j<32; j++) {

						this.EIST010_UPT_APP2(vo, p_box, p_tr, j);
					
					}
					
					break;
				
			}
		}
	}
	
	public void EIST010_UPT_APP2(GauceValueObject vo, CBox p_box, TrBox p_tr, int dd) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);

		dao.EIST010_UPT_APP(vo, p_box, dd);

	}			
		
	
	/**
	 * 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */	
	public void EIST010_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST010DAO dao = new EIST010DAO("default", p_tr);

		dao.EIST010_DEL(vo, p_box);

	}	
	
	/**
	 * 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST010_DEL_02(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST010DAO dao = new EIST010DAO("default", p_tr);
		
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
			
				case 4:
					// 삭제하기 위한 DAO메소드 호출
					dao.EIST010_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}

