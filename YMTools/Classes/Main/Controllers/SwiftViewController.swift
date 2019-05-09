//
//  SwiftViewController.swift
//  YMTools
//
//  Created by Y on 2019/4/24.
//  Copyright © 2019 YM. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        print(sumOperation(101))
        
        findTwoSumOptimized([ 0,2,1,3,6], target: 8)
    }
    
    func setupUI()  {
        let btn = UIButton.init(type: .custom);
        btn.setTitle("Hit", for: .normal);
        btn.setTitleColor(UIColor.white, for: .normal);
        btn.backgroundColor = UIColor.blue;
        btn.frame = CGRect.init(x: 100, y: 100, width: 100, height: 50);
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        self.view.addSubview(btn);
    }
    
    @objc func btnClick(btn:UIButton) {
        
    }
    
    //计算从1到100数字的总和。
    func sumOperation(_ n:Int) -> Int {
        return (1 + n) * n/2
    }
    
    func findTwoSumOptimized(_ array: [Int], target: Int) -> (Int, Int)? {
        
        guard array.count > 1 else {
            return nil
        }
        //[0,2,1,3,6]
        var diffs = Dictionary<Int, Int>()
        
        for i in 0..<array.count {

            let left = array[i]

            let right = target - left
            print(left,right)
            if let foundIndex = diffs[right] {

                return (i, foundIndex)
                
            } else {
                
                diffs[left] = i
            }

        }
        
        return nil
    }



}
