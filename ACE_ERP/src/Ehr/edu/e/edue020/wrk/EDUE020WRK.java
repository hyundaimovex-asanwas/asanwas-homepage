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
	 * ����������û�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_SHR_00(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

        /** ����������û�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUE020_SHR_00(p_box);

	}

	/**
	 * ����������û�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

        /** ����������û�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUE020_SHR_01(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ����������û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

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
					
    				/** ����������û�� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUE020_INS(vo, p_box);
//					dao.EDUE020_INS_OBJT(vo, p_box);
					break;

				case 3:

					/** ����������û��UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUE020_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}
	/**
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_UPT_00( CBox p_box, TrBox p_tr ) throws CException {
		
		/**
		 * ����������û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("STS");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);
		
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
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ����������û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUE020DAO dao = new EDUE020DAO("default", p_tr);

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
					//insert
					break;

				case 3:
					//update
					break;

				case 4:

					/** ����������û�� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.EDUE020_DEL(vo, p_box);
					break;
			}
		}
	}
	
	/**
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE020_PROC( CBox p_box, TrBox p_tr ) throws CException {

		GauceDataSet ds = null;

		EDUE020DAO dao = new EDUE020DAO("default", p_tr);
        CBox result = dao.EDUE020_PROC(p_box);

        ds = getRtnDS(result.get("TEMP_S1")
                    ,result.get("TEMP_S2")
                    ,result.get("TEMP_S2").equals("0") ? "������ ���� �Ǿ����ϴ�." : "������ ������ ���� �Ͽ����ϴ�."
                    ,""
                    ,""
                    ,""
        );

        //rtn
        p_tr.setOutDataSet("dsRESULT", ds);
	}
	/**
     * ��� ó���� ���Ǵ� DS�� ��ȯ ��Ŵ
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
