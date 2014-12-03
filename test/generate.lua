require 'caffe'

nets_list = {}

table.insert(nets_list, {
  name = 'bvlc_alexnet',
  proto = './models/bvlc_alexnet/deploy.prototxt',
  binary = './models/bvlc_alexnet/bvlc_alexnet.caffemodel',
  imsize = 227,
  input = torch.rand(10,3,227,227):float(),
})

table.insert(nets_list, {
  name = 'bvlc_reference_caffenet',
  proto = './models/bvlc_reference_caffenet/deploy.prototxt',
  binary = './models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel',
  imsize = 227,
  input = torch.rand(10,3,227,227):float(),
})

table.insert(nets_list, {
  name = 'bvlc_reference_rcnn_ilsvrc13',
  proto = './models/bvlc_reference_rcnn_ilsvrc13/deploy.prototxt',
  binary = './models/bvlc_reference_rcnn_ilsvrc13/bvlc_reference_rcnn_ilsvrc13.caffemodel',
  imsize = 227,
  input = torch.rand(10,3,227,227):float(),
})
--[[
table.insert(nets_list, {
  name = 'finetune_flickr_style',
  proto = './models/034c6ac3865563b69e60/val.prototxt',
  binary = './models/034c6ac3865563b69e60/finetune_flickr_style.caffemodel',
  imsize = 227,
  input = torch.rand(10,3,227,227):float(),
})
--]]

for i,netprops in ipairs(nets_list) do
  net = caffe.Net(netprops.proto, netprops.binary)
  netprops.output = net:forward(netprops.input)
  net:reset()
end

torch.save('nets_list.bin', nets_list)
