package common.sys;

import com.octo.captcha.service.image.ImageCaptchaService;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;

public class MyCaptchaService
{
  // a singleton class
  private static ImageCaptchaService instance = new DefaultManageableImageCaptchaService();

  public static ImageCaptchaService getInstance()
  {
    return instance;
  }
}