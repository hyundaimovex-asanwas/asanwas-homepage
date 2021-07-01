package Ehr.pir.a.pira010.wrk;


import Ehr.pir.a.pira010.dao.PIRA010DAO;

import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.FileUtils;
import com.shift.gef.support.utility.FtpUtils;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA010WRK {

	/**
	 * �λ���ǥ �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA010DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		
		/** ��������ó�� ���� ���  **/		
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		
        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR(p_box);
		dao2.PIRA010_SHR_ACC(p_box);
		
	}

	/**
	 * Ʈ�������� �����Ͽ� �α��λ�������� ���� �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_01( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);

        /** �λ���ǥ INSERT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_INS_02(p_box);

	    /** �ֽ� ������� �λ���ǥ �����͸� ����ȸ **/
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/** �λ���ǥ  SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao2.PIRA010_SHR(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� ���Ի���� ���� �λ���ǥ �����͸� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_02( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);

        /** �λ���ǥ INSERT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_INS_02(p_box);

	    /** �ֽ� ������� �λ���ǥ �����͸� ����ȸ **/
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/**ftp���� ����ȭ���� was�� �ٿ�޴´�. **/

		/**FTP���� ���� �ٿ�ε� (���ϸ��� �ֹι�ȣ�� �Ǿ��ְ� jpg����) **/
		
		
		
		try{
			String filePath = FtpUtils.ftpDownloadFile(p_box.get("CET_NO").replaceAll("-", "")+".jpg");
			
			/**
			 * ������� ���ϸ� ����
			 * �����ϸ鼭 download�� ������ �ΰ� upload�� �̵�
			 **/
			
			//System.out.println("old filePath : "+filePath);
			//System.out.println("new filePath : "+filePath.substring(0,filePath.length()-17-9)+"upload/"+p_box.get("ENO_NO").replaceAll("-", "")+".jpg");
			FileUtils.rename(filePath, filePath.substring(0,filePath.length()-17-9)+"upload/"+p_box.get("ENO_NO").replaceAll("-", "")+".jpg");

			//�ֹι�ȣ�ε� ���� ����
			//FileUtils.deleteFile(filePath);
			
		}catch(BizException e) {
			//throw new BizException("Ȯ���ڰ� Ʋ���ų� �ش� ������ �����ϴ�.");
		}

		/** �λ���ǥ  SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao2.PIRA010_SHR(p_box);

	}

	
	
	
	/**
	 * Ʈ�������� �����Ͽ� �α��λ�������� ���� �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		
        /** �λ���ǥ INSERT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT(p_box);

		/** ��������ó�� ���� ���  **/
		dao2.PIRA010_PRT_ACC(p_box);
		
	    /** �ֽ� ������� �λ���ǥ �����͸� ����ȸ **/
		//PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/** �λ���ǥ  SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		//dao2.PIRA010_SHR(p_box);

	}	
	
	
	/**
	 * Ʈ�������� �����Ͽ� �з»��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT2( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �з»��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT2(p_box);	
		
	}		
	
	/**
	 * Ʈ�������� �����Ͽ� �ڰ��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT3( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT3(p_box);	
		
	}		
	
	
	/**
	 * Ʈ�������� �����Ͽ� �ڰ��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT4( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT4(p_box);	
		
	}		
	
	/**
	 * Ʈ�������� �����Ͽ� �Ի��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT5( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT5(p_box);	
		
	}		
	
	/**
	 * Ʈ�������� �����Ͽ� �Ի��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT6( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT6(p_box);	
		
	}	
	
	/**
	 * Ʈ�������� �����Ͽ� ��� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT7( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT7(p_box);	
		
	}	
	
	/**
	 * Ʈ�������� �����Ͽ� �������� ��ȸ �����͸� ���� �Ǵ� �����ϰ� ����ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT8( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** �λ���ǥ �ڰ��� ��ȸ�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA010_SHR_PRINT8(p_box);	
		
	}		
	
	
	/**
	 * Ʈ�������� �����Ͽ� �λ���ǥ �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �λ���ǥ �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao3 = new PIRA010DAO("default", p_tr);		
		
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

    				/** �λ���ǥ INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					//dao.PIRA010_INS(vo, p_box);
					//dao.PIRA010_INS_01(p_box);

					//�Ի��� ��¿� �����Ͱ� ������������ �ӽ� ���̺� �����Ѵ�.
					dao.PIRA010_INS_03(vo, p_box);
					
					/** ��������ó�� ���� ���  **/
					dao3.PIRA010_INS_ACC(p_box);
					
					break;

				case 3:
					/** �λ���ǥ UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA010_UPT(vo, p_box);
					dao2.PIRA010_INS_01(p_box);
					
					/** ��������ó�� ���� ���  **/					
					dao3.PIRA010_UPT_ACC(p_box);		
					
					break;

				case 4:
					//delete
					break;
			}
		}
	}
}

