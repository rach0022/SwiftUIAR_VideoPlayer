//
//  ViewController.swift
//  ARTracker
//
//  Created by Ravi Rachamalla on 2021-02-23.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // comment out the original outlet and add the arView and loadView
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // set the ar views delegate to self and set the scene as a SCNScene()
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // set up the images to track to our AR Resource Group
        if let trackingImageRepo = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            
            // bind our AR Configuration to the tracking image repo and
            // tell the AR kit how many images we want to track. In this case 1
            // but we can track up to 100
            configuration.trackingImages = trackingImageRepo
            configuration.maximumNumberOfTrackedImages = 1
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
     //Override to create and configure nodes for anchors added to the view's session.
    private func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        print("happens")
        // case the found anchor as an image anchor
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
        
        // get the name of the image from the image anchor
        guard let imageName = imageAnchor.name else { return nil }
        
        // now with the image name, make sure its the one we defined and then lets
        // add a node to the iamge
        if imageName == "oasis_DigOutYourSoul" {
            // create a planar geometry wiht the SCNPlane
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height )
            
            // create a node on our plane
            let planeNode = SCNNode(geometry: plane)
            // ontop of our node, create ahosting controller where we will load up our swiftui view
            createHostingController(for: planeNode)
            
            // add our new planenode to the node from the image detection
            node.addChildNode(planeNode)
            return node
        } else {
            return nil
        }
    }
    
    func createHostingController(for node: SCNNode) {
        // create a hosting controller with SwiftUI view
        let arVC = UIHostingController(rootView: SwiftUIARCardView())
        
        // Do this on the main thread
        DispatchQueue.main.async {
            arVC.willMove(toParent: self)
            // make the hosting VC a child to the main view controller
            self.addChild(arVC)
            
            // set the pixel size of the Card View
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
            // add the ar card view as a subview to the main view
            self.view.addSubview(arVC.view)
            
            // render the view on the plane geometry as a material
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<SwiftUIARCardView>, on node: SCNNode) {
        // create a new material
        let material = SCNMaterial()
        
        // this allows the card to render transparent parts the right way
        hostingVC.view.isOpaque = false
        
        // set the diffuse of the material to the view of the Hosting View Controller
        material.diffuse.contents = hostingVC.view
        
        // Set the material to the geometry of the node (plane geometry)
        node.geometry?.materials = [material]
        
        hostingVC.view.backgroundColor = UIColor.clear
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
