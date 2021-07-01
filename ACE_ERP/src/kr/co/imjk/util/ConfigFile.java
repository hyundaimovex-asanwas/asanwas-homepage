/**
 * ȯ�� �������Ϸ� ���� ���丮 ��θ� �о� ���� Ŭ���� <br>
 *
 * - Using : ConfigFile.get(String key) <br>
 *
 *
 */

package kr.co.imjk.util;


/**
 *  SystemProperties Ŭ������ instance �������� �ٷ� �����ϱ� ���� ���� Ŭ����
 */
public class ConfigFile{
    private static SystemProperties prop;

    private synchronized static SystemProperties getInstance(){
        if(prop == null){
            prop = new SystemProperties();
        }
        return prop;
    }

    public static String get(String key){
        return get(key, "");
    }

    public static String get(String key, String defValue){
        return getInstance().getProperties(key, defValue);
    }
}