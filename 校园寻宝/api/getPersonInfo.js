/**
 *获取用户个人信息
 */
 
import { mGet, mPost } from "../utils/request/xhr";
 
const getPersonInfo = (path,params) => mPost(path, params);
 
export { getPersonInfo };