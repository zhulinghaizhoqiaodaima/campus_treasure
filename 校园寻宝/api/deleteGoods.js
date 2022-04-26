/**
 * 删除物品
 */

import { mPost } from "../utils/request/xhr";

const deleteGoods = (path,params) => mPost(path, params);

export { deleteGoods };