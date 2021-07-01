package Ehr.yac.a.yaca090.dao;

//2015.01.27 �̵��� �߰��� driver ������ϸ� ���� �����... ��������..��...
//import Ehr.yac.a.yaca090.wrk.YACA090WRK;
import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class YACA090DAO extends AbstractDAO {

    /**
     * YACA090DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
     * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
     * @param p_conn    Connection
     * @param p_tr      TrBox
     * @throws CException
     */
    public YACA090DAO(String p_conn, TrBox p_tr) throws CException {
        /** SuperClass�� ������ ȣ�� **/
        super(p_conn, p_tr);
    }

    /**
     * JSP�� ���� ������ �߰�
     * Transaction �� ó����������
     * @param p_conn
     * @throws CException
     */
    public YACA090DAO(String p_conn) throws CException {
        super(p_conn);
    }

    /**
     * �۾� ��Ȳ �˻�
     * @param p_box
     * @throws CException
     */
    public void YACA090_SHR_LOG_DS(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA090_SHR_LOG");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("PIS_MM"))
        };

        prop.add("PRO_STS_MSG", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        /**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * ����ڼ���(�⵵���� �ٸ��� �Ѵ�.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_02(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_02_"+agn_yy+".SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * �������۾�(�⵵���� �ٸ��� �Ѵ�.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_03_2014.SF_INS_T_AC_RETACC_14(?, ?, '8', ?, ?, ?, ?, ?) }";

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("vo ==========================================="+vo);        
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * �������۾�(�⵵���� �ٸ��� �Ѵ�.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03_142(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_03_2014_2.SF_INS_T_AC_RETACC_142(?, ?, '8', ?, ?, ?, ?, ?) }";

        System.out.println("p_box   =========================================== " + p_box);	
    	System.out.println("vo ==========================================="+vo);        
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                           String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
    /**
     * �������۾�(�⵵���� �ٸ��� �Ѵ�.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03_15(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
       // String sql = "{ call PKG_XF_YACA090_INS_03_2015.SF_INS_T_AC_RETACC_15(?, ?, '8', ?, ?, ?, ?, ?) }";
        String sql = "{ call PKG_XF_YACA090_INS_03_2015.SF_INS_T_AC_RETACC_15(?, ?, '8', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";

        System.out.println("p_box   =========================================== " + p_box);	
    	System.out.println("vo ==========================================="+vo);          
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                           String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) }, //�۾��Ϸ�޼���
                
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) } //ó���ο�
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
    
    
    
    /**
     * �۾�����
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_04(CBox p_box, GauceValueObject vo) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_04.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                      String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };


        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * ����ڼ��� ���۾�
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_05(CBox p_box, GauceValueObject vo) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_05.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                      String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * �������۾� ���۾�
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_06(CBox p_box, GauceValueObject vo) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_06.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";   
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");          
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * �������۾� ���۾�
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_06_142(CBox p_box, GauceValueObject vo) throws CException {

        /** �ݾס����װ�� ��Ű�� ����  **/
        String sql = "{ call PKG_XF_YACA090_INS_06_2.SF_INS_T_AC_RETACC_142(?, ?, '8', ?, ?, ?, ?, ?) }";   
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");          
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//��
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//�۾���

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//ó���ο�
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//�����ο�
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//�۾��ܰ�
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //�۾��Ϸ�޼���
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
       
}
