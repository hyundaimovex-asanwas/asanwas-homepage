package Ehr.yac.a.yaca040.wrk;

import Ehr.yac.a.yaca040.dao.YACA040DAO;
import Ehr.yac.a.yaca060.dao.YACA060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA040WRK {

	/**
	 * 기부금공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR(p_box);

	}

	/**
	 * 기부금공제 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_05(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_05(p_box);

	}

	
	/**
	 * 기부금공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_14(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_14(p_box);

	}
	
	/**
	 * 기부금공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_15(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_15(p_box);

	}	

	/**
	 * 기부금공제 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR2_14(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR2_14(p_box);

	}	
	
	/**
	 * 기부금공제 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR2_15(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR2_15(p_box);

	}	
	

	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][14];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][11] == null && dsArray[k][12] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[k][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("PIS_YM") ;//
						dsArray[k][4]  = vo.get("REMARK") ;//							
						dsArray[k][5]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[k][6]  = vo.get("COM_NM") ;//					
						dsArray[k][7]  = vo.get("TOT_CNT") ;//		
						dsArray[k][8]  = vo.get("SUM_AMT") ;//		
						dsArray[k][9]  = vo.get("SEQ_NO") ;//
						dsArray[k][10] = vo.get("FAM_CD") ;//
						dsArray[k][11] = vo.get("FAM_NM");//
						dsArray[k][12] = vo.get("FAM_NO");//
						dsArray[k][13] = vo.get("NTS_YN");//	
						break;
					}
				}
		}

			//전체삭제후 다시 저장
			//System.out.println("voList.size()================="+voList.size());	
			//System.out.println("p_box()================="+p_box);
			dao.YACA040_DEL_01(p_box, voList.get(0));

			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][11] != null && dsArray[i][12] != null){
					dao.YACA040_INS(p_box, dsArray, i);
				}
			}			

			//System.out.println("p_box================="+p_box);				
			dao.YACA040_UPT_FAM(p_box);	

	}

	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV1_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
		}
			//전체삭제
			dao.YACA040_DEL_ALL_14(p_box, voList.get(0));
	}
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV1_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
		}
			//전체삭제
			dao.YACA040_DEL_ALL_15(p_box, voList.get(0));
	}
	
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV2_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][12];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][9] == null && dsArray[k][10] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[k][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("REMARK") ;//							
						dsArray[k][4]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[k][5]  = vo.get("COM_NM") ;//					
						dsArray[k][6]  = vo.get("TOT_CNT") ;//		
						dsArray[k][7]  = vo.get("SUM_AMT") ;//		
						dsArray[k][8] = vo.get("FAM_CD") ;//
						dsArray[k][9] = vo.get("FAM_NM");//
						dsArray[k][10] = vo.get("FAM_NO");//
						dsArray[k][11] = vo.get("NTS_YN");//	
						break;
					}
				}
		}

			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][9] != null && dsArray[i][10] != null){
			
					this.YACA040_INS_14(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	
	
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV2_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][12];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][9] == null && dsArray[k][10] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[k][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("REMARK") ;//							
						dsArray[k][4]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[k][5]  = vo.get("COM_NM") ;//					
						dsArray[k][6]  = vo.get("TOT_CNT") ;//		
						dsArray[k][7]  = vo.get("SUM_AMT") ;//		
						dsArray[k][8] = vo.get("FAM_CD") ;//
						dsArray[k][9] = vo.get("FAM_NM");//
						dsArray[k][10] = vo.get("FAM_NO");//
						dsArray[k][11] = vo.get("NTS_YN");//	
						break;
					}
				}
		}

			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][9] != null && dsArray[i][10] != null){
			
					this.YACA040_INS_15(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	
	
	
	public void YACA040_INS_14(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		dao.YACA040_INS_14(p_box, dsArray, i);

	}		
	
	
	public void YACA040_INS_15(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		dao.YACA040_INS_15(p_box, dsArray, i);

	}		
	
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV3_14( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_FAM_14(p_box);	

	}
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV3_15( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_FAM_15(p_box);	

	}
	
	
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV4_14( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_RET_14(p_box);	

	}
	
	/**
	 * 기부금공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_SAV4_15( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_RET_15(p_box);	

	}
	
	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA040_DEL(p_box, vo);
				break;
			}
		}
	}

	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_DEL_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA040_DEL_14(p_box, vo);
				break;
			}
		}
	}	
	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA040_DEL_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.YACA040_DEL_15(p_box, vo);
				break;
			}
		}
	}	
	
	
	public void YACA040_UPT_ACC(CBox p_box, TrBox p_tr) throws CException {

		YACA040DAO dao = new YACA040DAO("default", p_tr);
		dao.YACA040_UPT_FAM(p_box);
		dao.YACA040_UPT_ACC(p_box);
	}	
	
	public void YACA040_UPT_FAM_14(CBox p_box, TrBox p_tr) throws CException {

		YACA040DAO dao = new YACA040DAO("default", p_tr);
		dao.YACA040_UPT_FAM_14(p_box);

	}
	
	public void YACA040_UPT_FAM_15(CBox p_box, TrBox p_tr) throws CException {

		YACA040DAO dao = new YACA040DAO("default", p_tr);
		dao.YACA040_UPT_FAM_15(p_box);

	}
	
	public void YACA040_UPT_ACC_14(CBox p_box, TrBox p_tr) throws CException {

		YACA040DAO dao = new YACA040DAO("default", p_tr);
		dao.YACA040_UPT_ACC_14(p_box);
	}
	
	public void YACA040_UPT_ACC_15(CBox p_box, TrBox p_tr) throws CException {

		YACA040DAO dao = new YACA040DAO("default", p_tr);
		dao.YACA040_UPT_ACC_15(p_box);
	}
	
}
