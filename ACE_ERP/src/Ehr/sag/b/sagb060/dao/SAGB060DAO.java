package Ehr.sag.b.sagb060.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGB060DAO extends AbstractDAO {

	/**
	 * SAGB060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGB060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SAGB060_SHR(String eno_no) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                eno_no
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}

    /**
     * �޻�ó������ ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet SAGB060_CHK_WORKLOG(CBox p_box) throws CException {

        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("sag", "SAGB060_CHK_WORKLOG");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM").substring(0, 4)
               ,p_box.get("PIS_YM").substring(5, 7)
               ,p_box.get("SAL_GBN")
               ,p_box.get("BON_NUM")
        };

        /**Query  ���� �� �ڷ� ������� Return  **/
        return this.selectProcess(sql, bind, prop);

    }

    /**
	 * �������Ұ���File���� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGB060_DEL(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_DEL");
		Object[] bind = new Object[] {
					p_box.get("PIS_YM").substring(0, 4)
	               ,p_box.get("PIS_YM").substring(5, 7)
		};


			/** INSERT�޼ҵ� ȣ��  **/
			insertProcess(sql, bind);
		}

	/**
	 * �������Ұ���File���� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGB060_INS(CBox p_box, GauceValueObject vo, String WRK_SEQ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_INS");

        vo.set("PIS_YY" , p_box.get("PIS_YM").substring(0, 4));
        vo.set("PIS_MM" , p_box.get("PIS_YM").substring(5, 7));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),						//���� CODE
				vo.get("PIS_YY"),	//�ش�⵵
				vo.get("PIS_MM"),	//�ش��
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("SAL_CD"),							//�޿��׸�
				//SEQ��ȸ�� ����
				vo.get("OCC_CD"),						//���� CODE
				vo.get("PIS_YY"),	//�ش�⵵
				vo.get("PIS_MM"),	//�ش��
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("AD_TAG"),							//����/��������
				vo.get("AMOUNT"),						//�ݾ�
				vo.get("REMARK"),						//����
				vo.get("DPT_CD"),							//�μ� CODE
				vo.get("JOB_CD"),							//���� CODE
				p_box.get("vusrid"),//�Է���
				p_box.get("vusrid")	//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

    /**
     * �۾���ȣ ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet SAGB060_SHR_01(CBox p_box) throws CException {

        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("sag", "SAGB060_SHR_01");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM").substring(0, 4)
               ,p_box.get("PIS_YM").substring(5, 7)
        };

        /**Query  ���� �� �ڷ� ������� Return  **/
        return this.selectProcess(sql, bind, prop);

    }

}
