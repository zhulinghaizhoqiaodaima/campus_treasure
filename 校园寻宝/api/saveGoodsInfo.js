/**
 *获取物品信息
 */
 
import { mGet, mPost } from "../utils/request/xhr";
 
const saveGoodsInfo = (params) => mPost("/goods/save", params);
 
export { saveGoodsInfo };