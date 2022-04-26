/**
 *用户信息更新
 */
 
import { mPost } from "../utils/request/xhr";
 
const getUserSave = (params) => mPost("/user/save", params);
 
export { getUserSave };