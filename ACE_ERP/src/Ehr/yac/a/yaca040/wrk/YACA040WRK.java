package Ehr.yac.a.yaca040.wrk;

import Ehr.yac.a.yaca040.dao.YACA040DAO;
import Ehr.yac.a.yaca060.dao.YACA060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA040WRK {

	/**
	 * ��αݰ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR(p_box);

	}

	/**
	 * ��αݰ��� ���� ����ڸ� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_05(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_05(p_box);

	}

	
	/**
	 * ��αݰ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_14(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_14(p_box);

	}
	
	/**
	 * ��αݰ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR_15(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR_15(p_box);

	}	

	/**
	 * ��αݰ��� ���� ����ڸ� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR2_14(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR2_14(p_box);

	}	
	
	/**
	 * ��αݰ��� ���� ����ڸ� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA040_SHR2_15(CBox p_box, TrBox p_tr) throws CException {

			YACA040DAO dao = new YACA040DAO("default", p_tr);
			dao.YACA040_SHR2_15(p_box);

	}	
	

	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][14];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][11] == null && dsArray[k][12] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//�ͼӳ⵵
						dsArray[k][1]  = vo.get("ENO_NO") ;//�����ȣ
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("PIS_YM") ;//
						dsArray[k][4]  = vo.get("REMARK") ;//							
						dsArray[k][5]  = vo.get("COM_NO") ;//����ڵ�Ϲ�ȣ
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

			//��ü������ �ٽ� ����
			//System.out.println("voList.size()================="+voList.size());	
			//System.out.println("p_box()================="+p_box);
			dao.YACA040_DEL_01(p_box, voList.get(0));

			//�ٽ�  ����
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][11] != null && dsArray[i][12] != null){
					dao.YACA040_INS(p_box, dsArray, i);
				}
			}			

			//System.out.println("p_box================="+p_box);				
			dao.YACA040_UPT_FAM(p_box);	

	}

	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV1_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
		}
			//��ü����
			dao.YACA040_DEL_ALL_14(p_box, voList.get(0));
	}
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV1_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
		}
			//��ü����
			dao.YACA040_DEL_ALL_15(p_box, voList.get(0));
	}
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV2_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][12];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][9] == null && dsArray[k][10] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//�ͼӳ⵵
						dsArray[k][1]  = vo.get("ENO_NO") ;//�����ȣ
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("REMARK") ;//							
						dsArray[k][4]  = vo.get("COM_NO") ;//����ڵ�Ϲ�ȣ
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

			//�ٽ�  ����
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][9] != null && dsArray[i][10] != null){
			
					this.YACA040_INS_14(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV2_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][12];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][9] == null && dsArray[k][10] == null){
						dsArray[k][0]  = vo.get("PIS_YY") ;//�ͼӳ⵵
						dsArray[k][1]  = vo.get("ENO_NO") ;//�����ȣ
						dsArray[k][2]  = vo.get("REL_CD") ;//
						dsArray[k][3]  = vo.get("REMARK") ;//							
						dsArray[k][4]  = vo.get("COM_NO") ;//����ڵ�Ϲ�ȣ
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

			//�ٽ�  ����
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][9] != null && dsArray[i][10] != null){
			
					this.YACA040_INS_15(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	
	
	
	public void YACA040_INS_14(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		dao.YACA040_INS_14(p_box, dsArray, i);

	}		
	
	
	public void YACA040_INS_15(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		dao.YACA040_INS_15(p_box, dsArray, i);

	}		
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV3_14( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_FAM_14(p_box);	

	}
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV3_15( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_FAM_15(p_box);	

	}
	
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV4_14( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_RET_14(p_box);	

	}
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_SAV4_15( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		//System.out.println("p_box================="+p_box);				
		dao.YACA040_UPT_RET_15(p_box);	

	}
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
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
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_DEL_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
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
	 * ��αݰ������� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA040_DEL_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DONATION");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA040DAO dao = new YACA040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
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
