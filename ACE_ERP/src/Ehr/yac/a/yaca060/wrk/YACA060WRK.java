package Ehr.yac.a.yaca060.wrk;

import Ehr.yac.a.yaca060.dao.YACA060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA060WRK {

	/**
	 * 연금저축공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA060_SHR(CBox p_box, TrBox p_tr) throws CException {

			YACA060DAO dao = new YACA060DAO("default", p_tr);
			dao.YACA060_SHR(p_box);

	}

	/**
	 * 연금저축공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA060_SHR_14(CBox p_box, TrBox p_tr) throws CException {

			YACA060DAO dao = new YACA060DAO("default", p_tr);
			dao.YACA060_SHR_14(p_box);

	}
	
	/**
	 * 연금저축공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA060_SHR_15(CBox p_box, TrBox p_tr) throws CException {

			YACA060DAO dao = new YACA060DAO("default", p_tr);
			dao.YACA060_SHR_15(p_box);

	}
	
	
	/**
	 * 연금저축공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		String dsArray[][] = null;
	
		dsArray = new String[voList.size()][13];
		

		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			//System.out.println("aaa"+vo);
			
				for (int k=0; k<voList.size(); k++) {

					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null && dsArray[k][3] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//
						dsArray[k][1]  = vo.get("ENO_NO") ;//
						dsArray[k][2]  = vo.get("PEN_TYPE_CD") ;//
						dsArray[k][3]  = vo.get("PEN_TYPE_NM") ;//
						dsArray[k][4]  = vo.get("PEN_GUBUN_CD") ;//							
						dsArray[k][5]  = vo.get("PEN_GUBUN_NM") ;//
						dsArray[k][6]  = vo.get("SEQ_NO") ;//					
						dsArray[k][7]  = vo.get("ABA_CD") ;//		
						dsArray[k][8]  = vo.get("ABA_NM") ;//		
						dsArray[k][9]  = vo.get("ACC_NO") ;//
						dsArray[k][10] = vo.get("YEAR_SEQ") ;//
						dsArray[k][11] = vo.get("AMOUNT");//
						dsArray[k][12] = vo.get("NTS_YN");//
						break;
					}
				}

		}
			//전체삭제후 다시 저장
			//System.out.println("voList.size()================="+voList.size());	
			dao.YACA060_DEL_01(p_box, voList.get(0));
			
			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][2] != null && dsArray[i][3] != null){
					dao.YACA060_INS(p_box, dsArray, i);
				}
			}		
	}

	/**
	 * 연금저축공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_SAV_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		String dsArray[][] = null;
	
		dsArray = new String[voList.size()][12];

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			//System.out.println("aaa"+vo);

				for (int k=0; k<voList.size(); k++) {

					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null && dsArray[k][3] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//
						dsArray[k][1]  = vo.get("ENO_NO") ;//
						dsArray[k][2]  = vo.get("PEN_TYPE_CD") ;//
						dsArray[k][3]  = vo.get("PEN_TYPE_NM") ;//
						dsArray[k][4]  = vo.get("PEN_GUBUN_CD") ;//							
						dsArray[k][5]  = vo.get("PEN_GUBUN_NM") ;//
						dsArray[k][6]  = vo.get("SEQ_NO") ;//							
						dsArray[k][7]  = vo.get("ABA_CD") ;//		
						dsArray[k][8]  = vo.get("ABA_NM") ;//		
						dsArray[k][9]  = vo.get("ACC_NO") ;//
						dsArray[k][10]  = vo.get("AMOUNT");//
						dsArray[k][11]  = vo.get("NTS_YN");//
						break;
					}
				}

		}
			//전체삭제후 다시 저장
			//System.out.println("voList.size()================="+voList.size());	
			dao.YACA060_DEL2_14(p_box, voList.get(0));
			
			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][2] != null && dsArray[i][3] != null){
					//dao.YACA060_INS(p_box, dsArray, i);
					//dao.YACA030_INS(p_box, dsArray, i);
					this.YACA060_INS_14(p_box, dsArray, i, p_tr);					
					
				}
			}		
	}	
	
	
	/**
	 * 연금저축공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_SAV_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		String dsArray[][] = null;
	
		dsArray = new String[voList.size()][13];

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			//System.out.println("aaa"+vo);

				for (int k=0; k<voList.size(); k++) {

					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null && dsArray[k][3] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//
						dsArray[k][1]  = vo.get("ENO_NO") ;//
						dsArray[k][2]  = vo.get("PEN_TYPE_CD") ;//
						dsArray[k][3]  = vo.get("PEN_TYPE_NM") ;//
						dsArray[k][4]  = vo.get("PEN_GUBUN_CD") ;//							
						dsArray[k][5]  = vo.get("PEN_GUBUN_NM") ;//
						dsArray[k][6]  = vo.get("SEQ_NO") ;//							
						dsArray[k][7]  = vo.get("ABA_CD") ;//		
						dsArray[k][8]  = vo.get("ABA_NM") ;//		
						dsArray[k][9]  = vo.get("ACC_NO") ;//
						dsArray[k][10]  = vo.get("AMOUNT");//
						dsArray[k][11]  = vo.get("NTS_YN");//
						dsArray[k][12]  = vo.get("IN_GB");//
						break;
					}
				}

		}
			//전체삭제후 다시 저장
			System.out.println("voList.size()================="+voList.size());	
			dao.YACA060_DEL2_15(p_box, voList.get(0));
			
			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][2] != null && dsArray[i][3] != null){
					//dao.YACA060_INS(p_box, dsArray, i);
					//dao.YACA030_INS(p_box, dsArray, i);
					this.YACA060_INS_15(p_box, dsArray, i, p_tr);					
					
				}
			}		
	}	
	
	public void YACA060_INS_14(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		dao.YACA060_INS_14(p_box, dsArray, i);

	}	
	
	public void YACA060_INS_15(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		dao.YACA060_INS_15(p_box, dsArray, i);

	}	
	
	
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		//System.out.println("voList.size()================="+voList.size());	
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
					
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA060_DEL(p_box, vo);
				break;
			}			
		}
	}

	
	public void YACA060_DEL_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA060_DEL_01(p_box, vo);
				break;
			}
		}

	}	
	
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_DEL_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		//System.out.println("voList.size()================="+voList.size());	
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
					
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA060_DEL_14(p_box, vo);
				break;
			}			
		}
	}
	
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA060_DEL_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		//System.out.println("voList.size()================="+voList.size());	
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
					
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA060_DEL_15(p_box, vo);
				break;
			}			
		}
	}

	
	public void YACA060_DEL2_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PENSION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA060DAO dao = new YACA060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA060_DEL2_14(p_box, vo);
				break;
			}
		}

	}		
	
	public void YACA060_UPT_ACC(CBox p_box, TrBox p_tr) throws CException {

		YACA060DAO dao = new YACA060DAO("default", p_tr);
		dao.YACA060_UPT_FAM(p_box);
		dao.YACA060_UPT_ACC(p_box);

	}

	public void YACA060_UPT_FAM_14(CBox p_box, TrBox p_tr) throws CException {

		YACA060DAO dao = new YACA060DAO("default", p_tr);
		dao.YACA060_UPT_FAM_14(p_box);


	}	
	
	public void YACA060_UPT_ACC_14(CBox p_box, TrBox p_tr) throws CException {

		YACA060DAO dao = new YACA060DAO("default", p_tr);

		dao.YACA060_UPT_ACC_14(p_box);

	}	
	
	public void YACA060_UPT_ACC_15(CBox p_box, TrBox p_tr) throws CException {

		YACA060DAO dao = new YACA060DAO("default", p_tr);

		dao.YACA060_UPT_ACC_15(p_box);

	}	

}
