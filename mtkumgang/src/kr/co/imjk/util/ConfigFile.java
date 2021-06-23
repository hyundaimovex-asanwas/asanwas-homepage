/**
 * 환경 설정파일로 부터 디렉토리 경로를 읽어 오는 클래스 <br>
 *
 * - Using : ConfigFile.get(String key) <br>
 *
 *
 */

package kr.co.imjk.util;


/**
 *  SystemProperties 클래스의 instance 생성없이 바로 접근하기 위해 만든 클래스
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