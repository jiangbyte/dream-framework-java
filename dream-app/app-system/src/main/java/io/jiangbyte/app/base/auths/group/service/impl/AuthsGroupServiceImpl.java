package io.jiangbyte.app.base.auths.group.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.auths.group.entity.AuthsGroup;
import io.jiangbyte.app.base.auths.group.dto.AuthsGroupDto;
import io.jiangbyte.app.base.auths.group.dto.AuthsGroupPageQuery;
import io.jiangbyte.app.base.auths.group.mapper.AuthsGroupMapper;
import io.jiangbyte.app.base.auths.group.service.AuthsGroupService;
import io.jiangbyte.framework.utils.SortUtils;
import io.jiangbyte.framework.exception.BusinessException;
import io.jiangbyte.framework.pojo.BasePageRequest;
import io.jiangbyte.framework.result.ResultCode;
import io.jiangbyte.framework.utils.TreeBuilder;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author Charlie Zhang
 * @version v1.0
 * @date 2025-06-23
 * @description 用户组表 服务实现类
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthsGroupServiceImpl extends ServiceImpl<AuthsGroupMapper, AuthsGroup> implements AuthsGroupService {

    @Override
    public Page<AuthsGroup> page(AuthsGroupPageQuery req) {
        QueryWrapper<AuthsGroup> queryWrapper = new QueryWrapper<AuthsGroup>().checkSqlInjection();
        if (ObjectUtil.isNotEmpty(req.getKeyword())) {
            queryWrapper.lambda().like(AuthsGroup::getName, req.getKeyword());
        }
        SortUtils.handleSort(AuthsGroup.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(AuthsGroupDto req) {
        AuthsGroup bean = BeanUtil.toBean(req, AuthsGroup.class);
        bean.setId(null);

        // 自动设置
        if (bean.getPid() == null || bean.getPid().equals("0")) {
            // 顶级节点
            bean.setPidPath("0");
        } else {
            // 查询父级的
            AuthsGroup parent = this.getById(bean.getPid());
            if (parent == null) {
                throw new IllegalArgumentException("父级用户组不存在");
            }
            // 防御性校验：父ID不能等于自己（虽然新增时ID为空，但以防前端传了id）
            if (req.getId() != null && req.getId().equals(bean.getPid())) {
                throw new BusinessException("父级不能是自身");
            }
            // 新的 pidPath = 父级的 pidPath + "," + 父级ID
            String newAncestors = parent.getPidPath() + "," + parent.getId();
            bean.setPidPath(newAncestors);
        }

        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(AuthsGroupDto req) {
        if (!this.exists(new LambdaQueryWrapper<AuthsGroup>().eq(AuthsGroup::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        AuthsGroup oldGroup = BeanUtil.toBean(req, AuthsGroup.class);
        AuthsGroup updated = BeanUtil.toBean(req, AuthsGroup.class);

        // 判断 pid 是否发生变化
        boolean pidChanged = !Objects.equals(oldGroup.getPid(), updated.getPid());

        if (pidChanged) {
            if (isAncestorOf(updated.getId(), updated.getPid())) {
                throw new BusinessException("不能将用户组移动到自己的子级下");
            }

            // 1. 重新计算当前节点的 pidPath
            String newPidPath;
            if (updated.getPid() == null || "0".equals(updated.getPid())) {
                newPidPath = "0";
            } else {
                AuthsGroup newParent = this.getById(updated.getPid());
                if (newParent == null) {
                    throw new BusinessException("父级用户组不存在");
                }
                newPidPath = newParent.getPidPath() + "," + newParent.getId();
            }
            updated.setPidPath(newPidPath);

            // 2. 递归更新所有子节点的 pidPath
            updateChildrenPidPath(updated.getId(), newPidPath);
        }

        // 执行更新（包含可能的新 pidPath）
        this.updateById(updated);
    }

    // 辅助方法：判断 targetId 是否是 nodeId 的祖先
    private boolean isAncestorOf(String nodeId, String targetId) {
        if (targetId == null || "0".equals(targetId)) {
            return false;
        }
        AuthsGroup node = this.getById(nodeId);
        if (node == null) return false;
        // 检查 targetId 是否出现在 node 的 pidPath 中
        return Arrays.asList(node.getPidPath().split(","))
                .contains(targetId);
    }

    /**
     * 递归更新指定节点下所有子节点的 pidPath
     *
     * @param parentId      当前父节点ID（作为子树根）
     * @param parentPidPath 父节点新的 pidPath
     */
    private void updateChildrenPidPath(String parentId, String parentPidPath) {
        // 查询直接子节点
        List<AuthsGroup> children = this.lambdaQuery()
                .eq(AuthsGroup::getPid, parentId)
                .list();

        for (AuthsGroup child : children) {
            // 新的 pidPath = 父级新 pidPath + "," + 当前子节点ID
            String newChildPidPath = parentPidPath + "," + child.getId();
            child.setPidPath(newChildPidPath);
            this.updateById(child);

            // 递归处理孙子节点
            updateChildrenPidPath(child.getId(), newChildPidPath);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<String> ids) {
        if (ObjectUtil.isEmpty(ids)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        this.removeByIds(ids);
    }

    @Override
    public AuthsGroup detail(String id) {
        AuthsGroup authsGroup = this.getById(id);
        if (ObjectUtil.isEmpty(authsGroup)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return authsGroup;
    }

    @Override
    public List<AuthsGroup> latest(int n) {
        return this.list(new QueryWrapper<AuthsGroup>()
                .lambda()
                .orderByDesc(AuthsGroup::getId)
                .last("limit " + n));
    }

    @Override
    public List<AuthsGroup> topN(int n) {
        return this.list(new QueryWrapper<AuthsGroup>()
                .lambda()
                .orderByDesc(AuthsGroup::getId)
                .last("limit " + n));
    }

    @Override
    public List<AuthsGroup> getAuthsGroupListTreeWithAccountID(String accountId, String keyword) {
        // 获取扁平菜单列表
        List<AuthsGroup> groups = getAuthsGroupListWithAccountID(accountId, keyword);

        // 使用TreeBuilder构建树形结构
        TreeBuilder<AuthsGroup> treeBuilder = new TreeBuilder<>(
                AuthsGroup::getId,
                group -> group.getPid() == null ? "" : group.getPid(),
                AuthsGroup::setChildren
        );

        return treeBuilder.buildTree(groups);
    }

    @Override
    public List<AuthsGroup> getAuthsGroupListWithAccountID(String accountId, String keyword) {
        return this.baseMapper.selectGroupsByAccountId(accountId, keyword);
    }

}