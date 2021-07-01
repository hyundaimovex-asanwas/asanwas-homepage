package Ehr.yac.a.yaca030.wrk;

import Ehr.yac.a.yaca030.dao.YACA030DAO;

import java.lang.reflect.Array;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA030WRK {

	/**
	 * 의료비공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);
			dao.YACA030_SHR(p_box);

	}

	/**
	 * 의료비공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR_14(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);
			
			dao.YACA030_SHR_14(p_box);

	}	
	
	/**
	 * 의료비공제내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR_15(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);
			
			dao.YACA030_SHR_15(p_box);

	}	
	
	
	/**
	 * 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR_FAM(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);
			
			//System.out.println("p_box = "+p_box);			
			dao.YACA030_SHR_FAM(p_box);

	}	
	
	/**
	 * 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_14(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);

			dao.YACA030_SHR_FAM_14(p_box);

	}		
	
	/**
	 * 공제 대상자를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_15(CBox p_box, TrBox p_tr) throws CException {

			YACA030DAO dao = new YACA030DAO("default", p_tr);

			dao.YACA030_SHR_FAM_15(p_box);

	}		
	
	
	/**
	 * 의료비공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		String insFlag = "";
		String voPIS_YY = "";
		String voENO_NO = "";
		String voCOM_NO = "";
		String voCET_NO = "";
		String voMED_CD = "";		
		String arrPIS_YY = "";
		String arrENO_NO = "";
		String arrCOM_NO = "";
		String arrCET_NO = "";
		String arrMED_CD = "";
		
		//System.out.print("p_tr ================= "+p_tr);	
		String dsArray[][] = null;

		dsArray = new String[voList.size()][13];

		for (int i=0; i<voList.size(); i++) {
			
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			insFlag = "Y";
			voPIS_YY = vo.get("PIS_YY");
			voENO_NO = vo.get("ENO_NO");
			voCOM_NO = vo.get("COM_NO");	//사업자등록번호
			voCET_NO = vo.get("CET_NO");		//주민번호
			voMED_CD = vo.get("MED_CD");		//의료증빙코드

			for (int j=0; j<voList.size(); j++) {
				//System.out.println("-->1번for = "+dsArray[j][10]);
				if(dsArray[j][0] != null && dsArray[j][1] != null && dsArray[j][7] != null && dsArray[j][10] != null && dsArray[j][12] != null){
					arrPIS_YY = dsArray[j][0];//PIS_YY
					arrENO_NO = dsArray[j][1];//ENO_NO
					arrCOM_NO = dsArray[j][7];//COM_NO
					arrCET_NO = dsArray[j][10];//CET_NO
					arrMED_CD = dsArray[j][12];//MED_CD
					
					//System.out.println(arrPIS_YY+":"+voPIS_YY+",  "+arrENO_NO+":"+voENO_NO+",  "+arrCOM_NO+":"+voCOM_NO+",  "+arrCET_NO+":"+voCET_NO);
					//년도, 사번, 사업자번호, 주민번호,의료증빙코드가 같으면 건수 및 진료비를 더해준다.
					if(arrPIS_YY.equals(voPIS_YY) && arrENO_NO.equals(voENO_NO) && arrCOM_NO.equals(voCOM_NO) && arrCET_NO.equals(voCET_NO) && arrMED_CD.equals(voMED_CD)){
						//System.out.println("더하는곳에 들어옴");
						insFlag = "N";

						dsArray[j][0]  = vo.get("PIS_YY") ;//귀속녀도
						dsArray[j][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[j][2]  = Long.toString(Long.parseLong(dsArray[j][2]) + Long.parseLong(vo.get("CARD_AMT")));//카드(현금영수증)
						dsArray[j][3]  = Long.toString(Long.parseLong(dsArray[j][3]) + Long.parseLong(vo.get("CARD_CNT")));//진료건수
						dsArray[j][4]  = Long.toString(Long.parseLong(dsArray[j][4]) + Long.parseLong(vo.get("CASH_AMT")));//현금
						dsArray[j][5]  = Long.toString(Long.parseLong(dsArray[j][5]) + Long.parseLong(vo.get("CASH_CNT")));//진료건수
						dsArray[j][6]  = Long.toString(Long.parseLong(dsArray[j][6]) + Long.parseLong(vo.get("SUM_AMT" )));//총진료비
						dsArray[j][7]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[j][8]  = vo.get("COM_NM") ;//진료기관명
						dsArray[j][9]  = vo.get("REL_CD") ;//관계
						dsArray[j][10] = vo.get("CET_NO") ;//주민번호
						dsArray[j][11] = vo.get("GBN_TAG");//구분
						dsArray[j][12] = vo.get("MED_CD");//의료증빙코드
					}
				}
			}

			if(insFlag.equals("Y")){
				for (int k=0; k<voList.size(); k++) {
					//System.out.println("-->2번for = "+dsArray[k][10]);
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][7] == null && dsArray[k][10] == null && dsArray[k][12] == null){

						dsArray[k][0]  = vo.get("PIS_YY")  ;//귀속녀도
						dsArray[k][1]  = vo.get("ENO_NO")  ;//사원번호
						dsArray[k][2]  = vo.get("CARD_AMT");//카드(현금영수증)
						dsArray[k][3]  = vo.get("CARD_CNT");//진료건수
						dsArray[k][4]  = vo.get("CASH_AMT");//현금
						dsArray[k][5]  = vo.get("CASH_CNT");//진료건수
						dsArray[k][6]  = vo.get("SUM_AMT") ;//총진료비
						dsArray[k][7]  = vo.get("COM_NO")  ;//사업자등록번호
						dsArray[k][8]  = vo.get("COM_NM")  ;//진료기관명
						dsArray[k][9]  = vo.get("REL_CD")  ;//관계
						dsArray[k][10] = vo.get("CET_NO")  ;//주민번호
						dsArray[k][11] = vo.get("GBN_TAG") ;//구분
						dsArray[k][12] = vo.get("MED_CD") ;//의료증빙코드

						break;
					}
				}
			}
		}

		for (int i=0; i<voList.size(); i++) {
			//System.out.print(i+" : ");
			for (int j=0; j<12; j++) {
				//System.out.print(" "+dsArray[i][j]);

			}
			//System.out.println(" ");
		}

		//전체삭제후 다시 저장
		dao.YACA030_DEL_01(p_box, voList.get(0));

		//다시 전체 저장
		//for (int i=0; i<voList.size(); i++) {
		//	if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][7] != null && dsArray[i][10] != null){
		//		dao.YACA030_INS(p_box, dsArray, i);
		//	}
		//}
		//다시 전체 저장
		this.YACA030_SAV2(p_box, p_tr);
		
	}


    //변경 내역 반영
    //this.YACA021_UPT_ACC(p_box, p_tr);		
	
	public void YACA030_SAV2(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		String dsArray[][] = null;

		dsArray = new String[voList.size()][13];
	
		
		//다시 전체 저장
		for (int i=0; i<voList.size(); i++) {
			
			//System.out.print("dsArray[i][j] ================= "+dsArray[i][0]);				
			//System.out.print("dsArray[i][j] ================= "+dsArray[i][1]);					
			
			if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][7] != null && dsArray[i][10] != null){
		
				dao.YACA030_INS(p_box, dsArray, i);
			}
		}

	}

	
	
	
	
	
	/**
	 * 의료비공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_SAV_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		String insFlag = "";
		String voPIS_YY = "";
		String voENO_NO = "";
		String voCOM_NO = "";
		String voCET_NO = "";
		String voMED_CD = "";		
		String arrPIS_YY = "";
		String arrENO_NO = "";
		String arrCOM_NO = "";
		String arrCET_NO = "";
		String arrMED_CD = "";
		
		//System.out.print("p_box ================= "+p_box);	
		
		String dsArray[][] = null;

		dsArray = new String[voList.size()][10];

		for (int i=0; i<voList.size(); i++) {
			
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			insFlag = "Y";
			voPIS_YY = vo.get("PIS_YY");
			voENO_NO = vo.get("ENO_NO");
			voCOM_NO = vo.get("COM_NO");	//사업자등록번호
			voCET_NO = vo.get("CET_NO");		//주민번호
			voMED_CD = vo.get("MED_CD");		//의료증빙코드

			for (int j=0; j<voList.size(); j++) {
				//System.out.println("-->1번for = "+dsArray[j][9]);
				if(dsArray[j][0] != null && dsArray[j][1] != null && dsArray[j][2] != null && dsArray[j][5] != null && dsArray[j][9] != null){
					arrPIS_YY = dsArray[j][0];//PIS_YY
					arrENO_NO = dsArray[j][1];//ENO_NO
					arrCOM_NO = dsArray[j][2];//COM_NO
					arrCET_NO = dsArray[j][5];//CET_NO
					arrMED_CD = dsArray[j][9];//MED_CD
					
					//System.out.println(arrPIS_YY+":"+voPIS_YY+",  "+arrENO_NO+":"+voENO_NO+",  "+arrCOM_NO+":"+voCOM_NO+",  "+arrCET_NO+":"+voCET_NO);
					//년도, 사번, 사업자번호, 주민번호,의료증빙코드가 같으면 건수 및 진료비를 더해준다.
					if(arrPIS_YY.equals(voPIS_YY) && arrENO_NO.equals(voENO_NO) && arrCOM_NO.equals(voCOM_NO) && arrCET_NO.equals(voCET_NO) && arrMED_CD.equals(voMED_CD)){
						//System.out.println("더하는곳에 들어옴");
						insFlag = "N";

						dsArray[j][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[j][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[j][2]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[j][3]  = vo.get("COM_NM") ;//진료기관명
						dsArray[j][4]  = vo.get("REL_CD") ;//관계
						dsArray[j][5] = vo.get("CET_NO") ;//주민번호
						dsArray[j][6] = vo.get("GBN_TAG");//구분
						dsArray[j][7]  = Long.toString(Long.parseLong(dsArray[j][7]) + Long.parseLong(vo.get("CASH_AMT")));//현금
						dsArray[j][8]  = Long.toString(Long.parseLong(dsArray[j][8]) + Long.parseLong(vo.get("CASH_CNT")));//진료건수						
						dsArray[j][9] = vo.get("MED_CD");//의료증빙코드
						
					}
				}
			}

			if(insFlag.equals("Y")){
				for (int k=0; k<voList.size(); k++) {
					//System.out.println("-->2번for = "+dsArray[k][9]);
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null && dsArray[k][5] == null && dsArray[k][9] == null){

						dsArray[k][0]  = vo.get("PIS_YY")  ;//귀속년도
						dsArray[k][1]  = vo.get("ENO_NO")  ;//사원번호
						dsArray[k][2]  = vo.get("COM_NO")  ;//사업자등록번호
						dsArray[k][3]  = vo.get("COM_NM")  ;//진료기관명
						dsArray[k][4]  = vo.get("REL_CD")  ;//관계
						dsArray[k][5] = vo.get("CET_NO")  ;//주민번호
						dsArray[k][6] = vo.get("GBN_TAG") ;//구분
						dsArray[k][7]  = vo.get("CASH_AMT");//현금
						dsArray[k][8]  = vo.get("CASH_CNT");//진료건수						
						dsArray[k][9] = vo.get("MED_CD") ;//의료증빙코드

						break;
					}
				}
			}
		}

		//전체삭제후 다시 저장
		dao.YACA030_DEL2_14(p_box, voList.get(0));

		//다시 전체 저장
		for (int i=0; i<voList.size(); i++) {
			if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][7] != null && dsArray[i][9] != null){
				//dao.YACA030_INS(p_box, dsArray, i);
				this.YACA030_SAV2_14(p_box, dsArray, i, p_tr);
			}
		}

		this.YACA030_UPT_ACC_14(p_box,  p_tr);
	
	}
	
	/**
	 * 의료비공제내역 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_SAV_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		String insFlag = "";
		String voPIS_YY = "";
		String voENO_NO = "";
		String voCOM_NO = "";
		String voCET_NO = "";
		String voMED_CD = "";		
		String arrPIS_YY = "";
		String arrENO_NO = "";
		String arrCOM_NO = "";
		String arrCET_NO = "";
		String arrMED_CD = "";
		
		System.out.print("YACA030_SAV_15 ================= "+p_box);	
		
		String dsArray[][] = null;

		dsArray = new String[voList.size()][10];

		for (int i=0; i<voList.size(); i++) {
			
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			insFlag = "Y";
			voPIS_YY = vo.get("PIS_YY");
			voENO_NO = vo.get("ENO_NO");
			voCOM_NO = vo.get("COM_NO");	//사업자등록번호
			voCET_NO = vo.get("CET_NO");		//주민번호
			voMED_CD = vo.get("MED_CD");		//의료증빙코드

			for (int j=0; j<voList.size(); j++) {
				//System.out.println("-->1번for = "+dsArray[j][9]);
				if(dsArray[j][0] != null && dsArray[j][1] != null && dsArray[j][2] != null && dsArray[j][5] != null && dsArray[j][9] != null){
					arrPIS_YY = dsArray[j][0];//PIS_YY
					arrENO_NO = dsArray[j][1];//ENO_NO
					arrCOM_NO = dsArray[j][2];//COM_NO
					arrCET_NO = dsArray[j][5];//CET_NO
					arrMED_CD = dsArray[j][9];//MED_CD
					
					//System.out.println(arrPIS_YY+":"+voPIS_YY+",  "+arrENO_NO+":"+voENO_NO+",  "+arrCOM_NO+":"+voCOM_NO+",  "+arrCET_NO+":"+voCET_NO);
					//년도, 사번, 사업자번호, 주민번호,의료증빙코드가 같으면 건수 및 진료비를 더해준다.
					if(arrPIS_YY.equals(voPIS_YY) && arrENO_NO.equals(voENO_NO) && arrCOM_NO.equals(voCOM_NO) && arrCET_NO.equals(voCET_NO) && arrMED_CD.equals(voMED_CD)){
						//System.out.println("더하는곳에 들어옴");
						insFlag = "N";

						dsArray[j][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[j][1]  = vo.get("ENO_NO") ;//사원번호
						dsArray[j][2]  = vo.get("COM_NO") ;//사업자등록번호
						dsArray[j][3]  = vo.get("COM_NM") ;//진료기관명
						dsArray[j][4]  = vo.get("REL_CD") ;//관계
						dsArray[j][5]  = vo.get("CET_NO") ;//주민번호
						dsArray[j][6]  = vo.get("GBN_TAG");//구분
						dsArray[j][7]  = Long.toString(Long.parseLong(dsArray[j][7]) + Long.parseLong(vo.get("CASH_AMT")));//현금
						dsArray[j][8]  = Long.toString(Long.parseLong(dsArray[j][8]) + Long.parseLong(vo.get("CASH_CNT")));//진료건수						
						dsArray[j][9]  = vo.get("MED_CD");//의료증빙코드
						
					}
				}
			}

			if(insFlag.equals("Y")){
				for (int k=0; k<voList.size(); k++) {
					//System.out.println("-->2번for = "+dsArray[k][9]);
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null && dsArray[k][5] == null && dsArray[k][9] == null){

						dsArray[k][0]  = vo.get("PIS_YY")  ;//귀속년도
						dsArray[k][1]  = vo.get("ENO_NO")  ;//사원번호
						dsArray[k][2]  = vo.get("COM_NO")  ;//사업자등록번호
						dsArray[k][3]  = vo.get("COM_NM")  ;//진료기관명
						dsArray[k][4]  = vo.get("REL_CD")  ;//관계
						dsArray[k][5] = vo.get("CET_NO")  ;//주민번호
						dsArray[k][6] = vo.get("GBN_TAG") ;//구분
						dsArray[k][7]  = vo.get("CASH_AMT");//현금
						dsArray[k][8]  = vo.get("CASH_CNT");//진료건수						
						dsArray[k][9] = vo.get("MED_CD") ;//의료증빙코드

						break;
					}
				}
			}
		}

		
		dao.setAutoCommit(false);
		
		//전체삭제후 다시 저장
		//dao.YACA030_DEL2_14(p_box, voList.get(0));
		dao.YACA030_DEL2_15(p_box, voList.get(0));

		//다시 전체 저장
		for (int i=0; i<voList.size(); i++) {
			if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][7] != null && dsArray[i][9] != null){
				//dao.YACA030_INS(p_box, dsArray, i);
				//this.YACA030_SAV2_14(p_box, dsArray, i, p_tr);
				this.YACA030_SAV2_15(p_box, dsArray, i, p_tr);
			}
		}
		
		System.out.print("YACA030_UPT_ACC_15 ================= "+p_box);	

		this.YACA030_UPT_ACC_15(p_box,  p_tr);
	
	}

	
	public void YACA030_SAV2_14(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		dao.YACA030_INS_14(p_box, dsArray, i);

	}
	
	
	public void YACA030_SAV2_15(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

		dao.YACA030_INS_15(p_box, dsArray, i);

	}



	/**
	 * 의료비공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

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
				//(국세청장이 제공하는 의료비의 자료경우)
				if(("1").equals(vo.get("MED_CD"))) {
					dao.YACA030_DEL_02(p_box, vo);
				} else {
					dao.YACA030_DEL(p_box, vo);
				}
				break;
			}
		}
	}
	
	
	/**
	 * 의료비공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_DEL_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

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
				//(국세청장이 제공하는 의료비의 자료경우)
				if(("1").equals(vo.get("MED_CD"))) {
					dao.YACA030_DEL3_14(p_box, vo);
				} else {
					dao.YACA030_DEL_14(p_box, vo);
				}
				break;
			}
		}
	}	
	
	/**
	 * 의료비공제내역 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void YACA030_DEL_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_MEDICAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA030DAO dao = new YACA030DAO("default", p_tr);

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
				//(국세청장이 제공하는 의료비의 자료경우)
				if(("1").equals(vo.get("MED_CD"))) {
					dao.YACA030_DEL3_15(p_box, vo);
				} else {
					dao.YACA030_DEL_15(p_box, vo);
				}
				break;
			}
		}
	}	
	

	public void YACA030_UPT_ACC(CBox p_box, TrBox p_tr) throws CException {

		YACA030DAO dao = new YACA030DAO("default", p_tr);
		dao.YACA030_UPT_FAM(p_box);
		dao.YACA030_UPT_ACC(p_box);
	}

	public void YACA030_UPT_FAM_14(CBox p_box, TrBox p_tr) throws CException {

		YACA030DAO dao = new YACA030DAO("default", p_tr);
		dao.YACA030_UPT_FAM_14(p_box);
		//dao.YACA030_UPT_ACC_14(p_box);
	}	
	
	public void YACA030_UPT_FAM_15(CBox p_box, TrBox p_tr) throws CException {

		YACA030DAO dao = new YACA030DAO("default", p_tr);
		dao.YACA030_UPT_FAM_15(p_box);
		//dao.YACA030_UPT_ACC_14(p_box);
	}	


	public void YACA030_UPT_ACC_14(CBox p_box, TrBox p_tr) throws CException {

		YACA030DAO dao = new YACA030DAO("default", p_tr);
		//dao.YACA030_UPT_FAM_14(p_box);
		dao.YACA030_UPT_ACC_14(p_box);
	}		
	
	public void YACA030_UPT_ACC_15(CBox p_box, TrBox p_tr) throws CException {

		YACA030DAO dao = new YACA030DAO("default", p_tr);
		//dao.YACA030_UPT_FAM_14(p_box);
		dao.YACA030_UPT_ACC_15(p_box);
	}		
	

}
