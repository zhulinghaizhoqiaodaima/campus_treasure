/**
 *用户头像上传
 */
 
import { mPost } from "../utils/request/xhr";
 
const UpLoadImg = (params) => mPost("/file/upload", params);
 
export { UpLoadImg };