//
//  GoodsStandardsController.swift
//  GlobalHouse_Swift
//
//  Created by 江奔 on 2018/3/27.
//  Copyright © 2018年 yueyi. All rights reserved.
//

import UIKit

class GoodsStandardsController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var goodImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let cellID = "cellID"
    fileprivate let headerViewID = "headViewID"
    
    fileprivate var tagsArr = [GoodsTags]()
    
    fileprivate var firstClassTagArr = [FirstGoodsClassTag]()
    fileprivate var secondClassTagArr = [SecondGoodsClassTag]()
    
    
    fileprivate var currentTagsOneChild: GoodsTagsChild?
    fileprivate var currentTagsTwoChild: GoodsTagsChild?
    
    // 确定
    @IBAction func sureClick(_ sender: UIButton) {
        kPrint(item: "确认")
    }
    
    // 关闭
    @IBAction func closeClick(_ sender: UIButton) {
        kPrint(item: "关闭")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        view.layer.backgroundColor = UIColor.clear.cgColor
        setViewBorderRadius(view: goodImgView, radius: 5, width: 0, color: UIColor.clear)
        
        setupItemModel()
        setupGoodsClassTag()
    }
    
    // 数据初始化
    fileprivate func setupItemModel() {
        
        let firstTags = ["920mm*128mm*11mm","920mm*128mm*15mm","920mm*128mm*10mm"]
        var firstTagsChilds = [GoodsTagsChild]() // 标签模型
        for i in 0..<firstTags.count {
            let child = GoodsTagsChild()
            child.childStr = firstTags[i]
            child.isSelected = false
            child.isCanClick = true // 刚进入默认可以点击
            firstTagsChilds.append(child)
        }
        let tags1 = GoodsTags()
        tags1.name = "长*宽*厚"
        tags1.child = firstTagsChilds
        
        
        let secondTags = ["1.3mm","1.4mm","1.5mm","1.2mm"]
        var secondTagsChilds = [GoodsTagsChild]()
        for i in 0..<secondTags.count {
            let child = GoodsTagsChild()
            child.childStr = secondTags[i]
            child.isSelected = false
            child.isCanClick = true // 刚进入默认可以点击
            secondTagsChilds.append(child)
        }
        let tags2 = GoodsTags()
        tags2.name = "木皮厚度"
        tags2.child = secondTagsChilds
        
        tagsArr = [tags1, tags2]
    }
    
    // 数据初始化
    fileprivate func setupGoodsClassTag() {
        // 模拟数据
        let arr1 = ["920mm*128mm*11mm","920mm*128mm*11mm","920mm*128mm*11mm","920mm*128mm*15mm","920mm*128mm*10mm","920mm*128mm*10mm","920mm*128mm*15mm","920mm*128mm*15mm"]
        let arr2 = ["1.3mm","1.4mm","1.5mm","1.2mm","1.3mm","1.4mm","1.5mm","1.3mm"]

        // 创建tagsinfo 对象
        var tagsInfos = [GoodTagsInfo]()
        for i in 0..<8 {
            let info = GoodTagsInfo()
            info.classTag2 = arr2[i]
            info.classTag1 = arr1[i]
            tagsInfos.append(info)
        }
        
        /*****************************************************************************/
        // 拿到所有(classTag1) 就是 　["920mm*128mm*11mm","920mm*128mm*15mm","920mm*128mm*10mm"]
        var firstClassTagKeys = [String]()
        for info in tagsInfos {
            let firstClassTagKey = info.classTag1
            if !firstClassTagKeys.contains(firstClassTagKey){
                firstClassTagKeys.append(firstClassTagKey)
            }
        }
        
        // 创建[FirstGoodsClassTag]数组
        var firstGoodsClassTags = [FirstGoodsClassTag]()
        // 对所有的(classTag1)拿到对应的classTag2集合  就是一个 "长*宽*厚" 对应 几个 "木皮厚度"
        for firstGoodsClassKey in firstClassTagKeys {
            let firstGoodsClassTag = FirstGoodsClassTag()
            firstGoodsClassTag.firstClassTagKey = firstGoodsClassKey
            
            var firstGoodClassTagValue = [String]()
            for info in tagsInfos {
                if info.classTag1 == firstGoodsClassKey {
                    firstGoodClassTagValue.append(info.classTag2)
                }
            }
            firstGoodsClassTag.firstClassTagValue = firstGoodClassTagValue
            firstGoodsClassTags.append(firstGoodsClassTag)
        }
        firstClassTagArr = firstGoodsClassTags // 赋值给全局变量
        
        /*****************************************************************************/
        // 拿到所有（classTag2） 就是[1.2mm 1.3mm 1.4mm 1.5mm]
        var classTagKeys = [String]()
        for info in tagsInfos {
            let classTagKey = info.classTag2
            if !classTagKeys.contains(classTagKey){
                classTagKeys.append(classTagKey)
            }
        }
        // 创建数组集合
        var secondGoodsClassTags = [SecondGoodsClassTag]()
        // 对所有（classTag2）拿到对应的 classTag1集合 就是一个 1.3mm 对应几个 长*宽*厚 类型
        for classTagKey in classTagKeys {
            let classTag = SecondGoodsClassTag()
            classTag.classTagKey = classTagKey
            
            var classTagValue = [String]()
            for info in tagsInfos {
                let classTagValueChild = info.classTag1
                if info.classTag2 == classTagKey {
                    classTagValue.append(classTagValueChild)
                }
            }
            classTag.classTagValue = classTagValue
            secondGoodsClassTags.append(classTag)
            
        }
        secondClassTagArr = secondGoodsClassTags // 赋值给去全局变量
    }

}
extension GoodsStandardsController {
    
    fileprivate func setupCollectionView() {
        
        self.collectionView.register(UINib.init(nibName: "GoodsStandardsCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        self.collectionView.register(UINib.init(nibName: "GoodsStandardsReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tags = tagsArr[section]
        return tags.child.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GoodsStandardsCell
        let tags = tagsArr[indexPath.section]
        let child = tags.child[indexPath.row]
        cell.tagsChild = child
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID, for: indexPath) as! GoodsStandardsReusableView
        let tags = tagsArr[indexPath.section]
        headerView.titleLable.text = tags.name
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            // 第一类
            let tagsOne = tagsArr[0]
            // 设置点击条目
            let clickChild = tagsOne.child[indexPath.row]
            if !clickChild.isCanClick {
                return
            }else {
                clickChild.isSelected = !clickChild.isSelected
                currentTagsOneChild = clickChild
            }
            // 设置非点击条目
            for child in tagsOne.child {
                if !child.isEqual(clickChild) {
                    child.isSelected = false
                }
            }
            // 第二类
            let tagsTwo = tagsArr[1] // 拿到 木皮厚度
            let tagsOneTitle = clickChild.childStr
            // 拿到所有第二类child条目title
            var tagsTwoChildStrs = [String]()
            for tagsTwoChild in tagsTwo.child {
                tagsTwoChildStrs.append(tagsTwoChild.childStr)
                tagsTwoChild.isCanClick = false
            }
            
            // 遍历"tags_child"类型数组
            for classTag in firstClassTagArr {
                if classTag.firstClassTagKey == tagsOneTitle { // 拿到和当前点击的title相同的classTag1
            //     {"classTag1":"920mm*128mm*11mm",
            //      "classTag2":["1.3mm","1.4mm","1.5mm"]}
                    for tagsTwoChild in tagsTwo.child {  // 遍历第二类属性数组 如果在第一类（classTag2）中有 就改变可选状态
                        for classTag2Str in classTag.firstClassTagValue {
                            if tagsTwoChild.childStr == classTag2Str {
                                tagsTwoChild.isCanClick = true // 包含就设置可选
                                // 如果当前包含的里面有当前被选的
                                if let currentTwoChild = currentTagsTwoChild {
                                    if currentTwoChild.childStr == tagsTwoChild.childStr{
                                        tagsTwoChild.isSelected = currentTwoChild.isSelected
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if indexPath.section == 1 {
            
            // 拿到第二类
            let tagsTwo = tagsArr[1]
            // 点击的第二类条目
            let clickChild = tagsTwo.child[indexPath.row]
            // 改变第二类条目状态
            if !clickChild.isCanClick {
                return
            }else {
                clickChild.isSelected = !clickChild.isSelected
                currentTagsTwoChild = clickChild
            }
            // 设置其他未被选条目状态未非选中状态
            for tagsTwoChild in tagsTwo.child {
                if !tagsTwoChild.isEqual(clickChild){
                    tagsTwoChild.isSelected = false
                }
            }
            
            // 第一类状态改变
            // 第一类
            let tagsOne = tagsArr[0] //
            // 拿到所有第一类child条目title
            var tagsOneChildStrs = [String]()
            for tagsOneChild in tagsOne.child {
                tagsOneChildStrs.append(tagsOneChild.childStr)
                tagsOneChild.isCanClick = false
            }
            
            for classTag in secondClassTagArr {
                if classTag.classTagKey == clickChild.childStr {
                    for tagsOneChild in tagsOne.child {
                        for classTagValueChild in classTag.classTagValue {
                            if tagsOneChild.childStr == classTagValueChild {
                                tagsOneChild.isCanClick = true
                                
                                if let currentOneChild = currentTagsOneChild {
                                    if currentOneChild.childStr == tagsOneChild.childStr {
                                        tagsOneChild.isSelected = currentOneChild.isSelected
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
        
        
        
        collectionView.reloadData()
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tags = tagsArr[indexPath.section]
        let child = tags.child[indexPath.row]
        let childStr = child.childStr
        let childStrW = childStr.ga_widthForComment(fontSize: 14.0, height: 30)
        return CGSize(width: childStrW + 20, height: 30)
    }
    
    // 左右行之间的距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 上下行之间的距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 设置区头
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 40)
    }
    
    // 设置内容内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
    
}


